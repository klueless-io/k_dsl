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
      # rubocop:disable Metrics/AbcSize
      def initialize(key, *args, **options, &block)
        @key = key
        @type = args.length.positive? ? args[0] || KDsl.config.default_document_type : KDsl.config.default_document_type

        @options = options || {}
        @namespace = options[:namespace] || ''
        @namespace = @namespace.to_s
        @data = {}

        # # L.kv 'CURRENT STATE', Klue::Dsl::RegisterDsl.get_instance.current_state
        return unless block_given? # if !Klue.registering && block_given?

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

        # Klue.register_instance_or_default.save self
      end
      # rubocop:enable Metrics/AbcSize

      def settings(key = nil, **options, &block)
        options ||= {}

        opts = {}.merge(@options) # Document Options
                 .merge(options)  # Settings Options

        # IOC/DI this instance
        settings = KDsl::Model::Settings.new(@data, key, k_parent: self, &block)
        settings.run_modifiers(opts)

        # # Shift into the settings class (+ tests)
        # modifiers = processor.modifiers(opts[:modifiers])
        # processor.modify_settings(modifiers, @data[settings.k_key])

        settings
      end

      def table(key = :table, &block)
        # IOC/DI this instance
        table = KDsl::Model::Table.new(@data, key, &block)

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

      private

      # Deprecate
      def processor
        @processor ||= KDsl::Modifier::Processor.new
      end
    end
  end
end
