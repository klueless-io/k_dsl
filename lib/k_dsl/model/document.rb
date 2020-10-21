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
      extend Forwardable

      attr_reader :key
      attr_reader :type
      attr_reader :namespace
      attr_reader :options
      attr_reader :error

      attr_accessor :resource

      def_delegator :resource, :project

      # Create document
      #
      # @param [String|Symbol] name Name of the document
      # @param args[0] Type of the document, defaults to KDsl.config.default_document_type if not set
      # @param default: Default value (using named params), as above
      def initialize(key = SecureRandom.alphanumeric(8), *args, **options, &block)
        @key = key
        @type = args.length.positive? ? args[0] || KDsl.config.default_document_type : KDsl.config.default_document_type

        @options = options || {}
        @namespace = options[:namespace] || ''
        default_data = options[:default_data] || {}
        
        @namespace = @namespace.to_s
        @error = nil

        # Most documents live within a hash, some tabular documents such as
        # CSV will use an []
        set_data(default_data)

        @block = block if block_given?
      end

      def execute_block(run_actions: nil)
        return if @block.nil?
        
        # The DSL actions method will only run on run_actions: true
        @run_actions = run_actions

        self.instance_eval(&@block)
     rescue KDsl::Error => exception1
        L.error("KDsl::Error in document")
        L.kv 'key', unique_key
        L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        L.error(exception1.message)
        @error = exception1
        # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
        # L.exception exception
        raise
      rescue StandardError => exception2
        L.error("Standard error in document")
        L.kv 'key', unique_key
        L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        L.error(exception2.message)
        @error = exception2
        # L.exception exception2
        raise
      ensure
        @run_actions = nil
        return
      end

      # REFACT: This is not really part of the document, so how could it be refactored
      #         and used as some sort of decorator or actionable module
      def actions(&action_block)
        return unless @run_actions

        instance_eval(&action_block)
      rescue KDsl::Error => exception1
        L.error("KDsl::Error in action")
        # L.kv 'key', unique_key
        # L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        # L.error(exception1.message)
        @error = exception1
        # L.exception exception1
        raise
      rescue StandardError => exception2
        L.error("Standard error in action")
        # L.kv 'key', unique_key
        # L.kv 'file', KDsl::Util.data.console_file_hyperlink(resource.file, resource.file)
        # L.error(exception2.message)
        @error = exception2
        # L.exception exception2
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

      def data_struct
        KDsl::Util.data.to_struct(data)
      end

      def raw_data_struct
        KDsl::Util.data.to_struct(raw_data)
      end

      def get_node_type(node_name)
        node_name = KDsl::Util.data.clean_symbol(node_name)
        node_data = @data[node_name]

        raise KDsl::Error, "Node not found: #{node_name}" if node_data.nil?

        if node_data.keys.length == 2 && (node_data.key?('fields') && node_data.key?('rows'))
          :table
        else
          :settings
        end
      end

      # Removes any meta data eg. "fields" from a table and just returns the raw data
      def raw_data
        # REFACT, what if this is CSV, meaning it is just an array?
        #         add specs
        result = data

        result.keys.each do |key|
          # ANTI: get_node_type uses @data while we are using @data.clone here
          if get_node_type(key) == :table
            data[key] = result[key].delete('fields')
          else
            data[key] = result[key]
          end
        end

        data
      end

      # Move this out to the logger function when it has been refactor
      def debug(include_header = false)
        debug_header if include_header

        # tp dsls.values, :k_key, :k_type, :state, :save_at, :last_at, :data, :last_data, :source, { :file => { :width => 150 } } 
        # puts JSON.pretty_generate(data)
        L.ostruct(raw_data_struct)
      end

      def debug_header
        L.heading self.class.name
        L.kv 'key', key
        L.kv 'type', type
        L.kv 'namespace', namespace

        options&.keys.reject { |k| k == :namespace }&.each do |key|
          L.kv key, options[key]
        end

        L.line
      end

      # Helpers that often get called by extensions

      def project
        project ||= resource&.project
      end

      # Warning message
      def warn(message)
        L.warn message
        nil
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
