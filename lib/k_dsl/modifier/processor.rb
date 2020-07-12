# frozen_string_literal: true

module KDsl
  module Modifier
    # Process modifiers
    #
    # When given a hash, the modifier can make a decision to alter that hash based on the hash contents.
    class Processor
      def self.processor
        @processor ||= KDsl::Modifier::Processor.new
      end

      def self.get_modifiers(modifiers)
        processor.modifiers(modifiers)
      end

      # Pass a set of modifiers using an array in the format of
      # :symbol, class or lambda
      #
      # :symbol will be looked up and a new class and then an instantiation will be returned
      # class will be instantiated and returned
      # nil is returned if the instance does not support the update method
      #
      # example: modifiers(:uppercase, MyCustomerClass, lambda { |hash| hash['add'] = 'something' })
      def modifiers(modifiers)
        return [] if modifiers.nil?

        modifiers.map do |modifier|
          if modifier.is_a?(Class)
            handle_class(modifier)
          elsif modifier.is_a?(Symbol)
            handle_symbol(modifier)
          else
            modifier
          end
        end.compact
      end

      def modify_settings(modifiers, data)
        return nil if data.nil?
        return data if modifiers.nil? || modifiers.empty?

        modifiers.each do |modifier|
          modifier.send(:update, data) if modifier.respond_to?(:update)
          modifier.send(:call, data) if modifier.respond_to?(:call)
        end

        data
      end

      private

      def handle_class(modifier)
        result = modifier.new
        result = nil unless result.respond_to?(:update)
        result
      end

      def handle_symbol(modifier)
        result = KDsl.config.get_modifier(modifier)&.new
        result = nil unless result.respond_to?(:update)
        result
      end
    end
  end
end
