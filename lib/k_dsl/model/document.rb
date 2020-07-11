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
      # rubocop:disable Style/RescueStandardError, Metrics/AbcSize
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

        begin
          instance_eval(&block)
        rescue => e
          puts "Invalid code block in document_dsl during registration: #{key}"
          puts e.message
          # L.heading "Invalid code block in document_dsl during registration: #{k_key}"
          # L.exception exception
          raise
        end

        # Klue.register_instance_or_default.save self
      end
      # rubocop:enable Style/RescueStandardError, Metrics/AbcSize

      def settings(key = nil, **options, &block)
        options ||= {}

        opts = {}.merge(@options) # Document Options
                 .merge(options)  # Settings Options

        settings = KDsl::Model::Settings.new(@data, key, k_parent: self, &block)

        modifiers = processor.modifiers(opts[:modifiers])
        processor.modify_settings(modifiers, @data[settings.k_key])

        settings
      end

      def table(key = :table, &block)
        @key = key

        table = KDsl::Model::Table.new(@data, key, &block)

        table
      end
      alias rows table

      def data
        @data.clone
      end

      private

      def processor
        @processor ||= KDsl::Modifier::Processor.new
      end
    end
  end
end
