# frozen_string_literal: true

module KDsl
  # Decorate table rows and settings.
  module Decorator
    class << self
      attr_accessor :helper
    end

    def self.decorate
      self.helper ||= KDsl::Decorator::Helper.new
    end

    # Decorators will decorate hashes.
    # Given a hash, they can add/remove keys and update values
    class Helper
      # Pass a set of decorators using an array in the format of
      # :symbol, class or lambda
      #
      # :symbol will be looked up and a new class and then an instantiation will be returned
      # class will be instantiated and returned
      # nil is returned if the instance does not support the update method
      #
      # example: decorators(:uppercase, MyCustomerClass, lambda { |hash| hash['add'] = 'something' })
      def decorators(decorators)
        return [] if decorators.nil?

        decorators.map do |decorator|
          if decorator.is_a?(Class)
            handle_class(decorator)
          elsif decorator.is_a?(Symbol)
            handle_symbol(decorator)
          else
            decorator
          end
        end.compact
      end

      def decorate_settings(decorators, data)
        return nil if data.nil?
        return data if decorators.nil? || decorators.empty?

        decorators.each do |decorator|
          decorator.send(:update, data) if decorator.respond_to?(:update)
          decorator.send(:call, data) if decorator.respond_to?(:call)
        end

        data
      end

      private

      def handle_class(decorator)
        result = decorator.new
        result = nil unless result.respond_to?(:update)
        result
      end

      def handle_symbol(decorator)
        result = KDsl.config.get_decorator(decorator)&.new
        result = nil unless result.respond_to?(:update)
        result
      end
    end
  end
end
