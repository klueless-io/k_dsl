# frozen_string_literal: true

require 'json'

module KDsl
  module Model
    # Builds up key/value settings from the block
    # and applies them to a key coded node on the hash
    class Settings
      attr_reader :k_parent
      attr_reader :k_key

      alias kp k_parent

      def initialize(data, key = nil, **options, &block)
        @data = data
        @k_key = (key || KDsl.config.default_settings_key).to_s

        @k_parent = options[:k_parent] if !options.nil? && options.key?(:k_parent)

        @data[@k_key] = {}

        # Need a way to find out the line number for errors and report it correctly
        begin
          instance_eval(&block) if block_given?
          # rubocop:disable Style/RescueStandardError
        rescue # => e
          # rubocop:enable Style/RescueStandardError
          # puts "Invalid code block in settings_dsl: #{@k_key}"
          # puts e.message
          # L.heading "Invalid code block in settings_dsl: #{@k_key}"
          # L.exception e
          raise
        end
      end

      # Refactor this
      def respond_to_missing?(name, *_args, &_block)
        n = name.to_s
        n = n[0..-2] if n.end_with?('=')
        @data[@k_key].key?(n.to_s)
      end

      def method_missing(name, *missing_method_args, &_block)
        raise DslError, 'Multiple setting values is not supported' if missing_method_args.length > 1

        add_getter_or_setter_method(name)
        add_setter_method(name)

        send("#{name}=", missing_method_args[0])

        super unless self.class.method_defined?(name)
      end

      def add_getter_or_setter_method(name)
        self.class.class_eval do
          define_method(name) do |*args|
            raise DslError, 'Multiple setting values is not supported' if args.length > 1

            if args.length.zero?
              get_value(name)
            else
              send("#{name}=", args[0])
            end
          end
        end
      end

      def add_setter_method(name)
        self.class.class_eval do
          define_method("#{name}=") do |value|
            @data[@k_key][name.to_s] = value
          end
        end
      end

      def get_value(name)
        @data[@k_key][name.to_s]
      end

      def to_h
        @data
      end

      def k_debug
        puts JSON.pretty_generate(@data[@k_key])
      end
    end
  end
end
