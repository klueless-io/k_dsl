# frozen_string_literal: true

module KDsl
  module Model
    # General purpose document DSL
    #
    # Made up of 0 or more setting groups and table groups
    class Document
      attr_accessor :resource
      attr_reader :key
      attr_reader :type
      attr_reader :namespace
      attr_reader :options

      # Create docoument
      #
      # @param [String|Symbol] name Name of the document
      # @param args[0] Type of the document, defaults to KDsl.config.default_document_type if not set
      # @param default: Default value (using named params), as above
      def initialize(key, *args, **options, &block)
        initialize_attributes(key, *args, **options)

        @block = block if block_given?
        # REFACT: Split out as
        #         Data and Document
        #         Document and DslDocument
      end

      def execute_block
        return if @block.nil?
        begin
          instance_eval(&@block)
        rescue KDsl::Error => e
          puts "Invalid code block in document during registration: #{key}"
          puts "__FILE__: #{__FILE__}"
          puts "__LINE__: #{__LINE__}"
          puts e.message
          # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
          # L.exception exception
          raise
        rescue StandardError => exception
          puts "Invalid code block in document during registration: #{key}"
          puts "__FILE__: #{__FILE__}"
          puts "__LINE__: #{__LINE__}"
          puts exception.message
          # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
          # L.exception exception
          raise
        end
      end

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

      # Spe
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

      # I don't like the *args, best of setting it up with :type
      def initialize_attributes(key, *args, **options)
        @key = key
        @type = args.length.positive? ? args[0] || KDsl.config.default_document_type : KDsl.config.default_document_type

        @options = options || {}
        @namespace = options[:namespace] || ''

        @namespace = @namespace.to_s

        # Most documents live within a hash, some tabular documents such as
        # CSV will use an []
        set_data({})
      end

      def settings_instance(data, key, **options, &block)
        KDsl.config.settings_class.new(data, key, **options, &block)
      end

      def table_instance(data, key, &block)
        KDsl.config.table_class.new(data, key, &block)
      end
    end
  end
end
