# frozen_string_literal: true

module KDsl
  module Model
    # TODO
    # Missing tests around errors
    # Make sure that error writes to resource or document appropriately
    # Puts errors onto a project manager pipeline so that they can be be printed out after the documents
    #
    # General purpose document DSL
    #
    # Made up of 0 or more setting groups and table groups
    class Document
      attr_accessor :resource
      attr_reader :key
      attr_reader :type
      attr_reader :namespace
      attr_reader :options
      attr_reader :error

      # Create docoument
      #
      # @param [String|Symbol] name Name of the document
      # @param args[0] Type of the document, defaults to KDsl.config.default_document_type if not set
      # @param default: Default value (using named params), as above
      def initialize(key, *args, **options, &block)
        @key = key
        @type = args.length.positive? ? args[0] || KDsl.config.default_document_type : KDsl.config.default_document_type

        @options = options || {}
        @namespace = options[:namespace] || ''

        @namespace = @namespace.to_s
        @error = nil

        # Most documents live within a hash, some tabular documents such as
        # CSV will use an []
        set_data({})

        @block = block if block_given?
      end

      def execute_block(run_actions: nil)
        return if @block.nil?
        
        # The DSL actions method will only run on run_actions: true
        @run_actions = run_actions

        self.instance_eval(&@block)
     rescue KDsl::Error => e
        L.error("KDsl::Error in document")
        L.kv 'key', unique_key
        L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        L.error exception.message
        @error = exception
        # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
        # L.exception exception
        raise
      rescue StandardError => exception
        L.error("Standard error in document")
        L.kv 'key', unique_key
        L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        L.error exception.message
        @error = exception
        # L.exception exception
        raise
      ensure
        @run_actions = nil
        return
      end

      # REFACT: This is not really part of the document, so how could it be refactored
      #         and used as some sort of decorator or importer module
      def import(key, type = KDsl.config.default_document_type, namespace = nil)
        project = resource&.project

        if project
          data = project.get_data(key, type, namespace)
          result = KDsl::Util.data.to_struct(data)
  
          result
        else
          Log.warn 'Import Skipped: Document is not linked to a project'
        end
      end

      # REFACT: This is not really part of the document, so how could it be refactored
      #         and used as some sort of decorator or actionable module
      def actions(&action_block)
        return unless @run_actions

        instance_eval(&action_block)
      rescue KDsl::Error => e
        L.error("KDsl::Error in action")
        L.kv 'key', unique_key
        L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        L.error exception.message
        @error = exception
        # L.exception exception
        raise
      rescue StandardError => exception
        L.error("Standard error in action")
        L.kv 'key', unique_key
        L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        L.error exception.message
        @error = exception
        # L.exception exception
        raise
      end
  
      def unique_key
        @unique_key ||= KDsl::Util.dsl.build_unique_key(key, type, namespace)
      end

      def settings(key = nil, **options, &block)
        options ||= {}

        opts = {}.merge(@options) # Document Options
                 .merge(options)  # Settings Options

        settings = settings_instance(@data, key, parent: self, &block)
        settings.run_decorators(opts)
        settings
      end

      def table(key = :table, &block)
        # NEED to add support for parent and run_decorators I think
        table = table_instance(@data, key, &block)

        table
      end
      alias rows table

      # Sweet add-on would be builders
      # def builder(key, &block)
      #   # example
      #   KDsl::Builder::Shotstack.new(@data, key, &block)
      # end

      def set_data(data)
        @data = data
      end

      def data
        @data.clone
      end

      # Move this out to the logger function when it has been refactor
      def debug(include_header = false)
        debug_header if include_header

        # tp dsls.values, :k_key, :k_type, :state, :save_at, :last_at, :data, :last_data, :source, { :file => { :width => 150 } } 
        puts JSON.pretty_generate(data)
      end

      def debug_header
        L.heading 'Document DSL'
        L.kv 'key', key
        L.kv 'type', type
        L.kv 'namespace', namespace

        options&.keys.reject { |k| k == :namespace }&.each do |key|
          L.kv key, options[key]
        end

        L.line
      end

      private

      def settings_instance(data, key, **options, &block)
        KDsl.config.settings_class.new(data, key, **options, &block)
      end

      def table_instance(data, key, &block)
        KDsl.config.table_class.new(data, key, &block)
      end
    end
  end
end
