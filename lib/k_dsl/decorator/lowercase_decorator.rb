# frozen_string_literal: true

module KDsl
  module Decorator
    # Turn all string and symbol values in the data hash into uppercase
    class LowercaseDecorator
      def update(data)
        data.update(data) do |_key, value|
          if value.is_a?(String)
            value.downcase
          elsif value.is_a?(Symbol)
            value.to_s.downcase
          else
            value
          end
        end
      end
    end
  end
end
