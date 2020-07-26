# frozen_string_literal: true

module KDsl
  module Model
    # General purpose document DSL
    #
    # Made up of 0 or more setting groups and table groups
    class Document
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

        KDsl.manager.register_with_project(self)

        # # L.kv 'CURRENT STATE', Klue::Dsl::RegisterDsl.get_instance.current_state
        return unless block_given?
        return unless block_executable?

        #   # L.kv 'AM I EVER IN', 'Artifact.new &Block'
        #   # L.block block.source

        # TODO: raise_error Unit Test
        begin
          instance_eval(&block)
        rescue KDsl::DslError => e
          puts "Invalid code block in document_dsl during registration: #{key}"
          puts e.message
          # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
          # L.exception exception
          raise
        end
      end

      def unique_key
        KDsl::Util.dsl.build_unique_key(key, type, namespace)
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

      def data
        @data.clone
      end

      def block_executable?
        @block_executable
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

        options&.keys&.each do |key|
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
        @block_executable = options[:block_executable].nil? ? true : options[:block_executable]
        @data = {}
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
