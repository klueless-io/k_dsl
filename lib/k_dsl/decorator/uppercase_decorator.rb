# frozen_string_literal: true

module KDsl
  module Decorator
    # Turn all string and symbol values in the data hash into lowercase
    class UppercaseDecorator
      def update(data)
        data.update(data) do |_key, value|
          if value.is_a?(String)
            value.upcase
          elsif value.is_a?(Symbol)
            value.to_s.upcase
          else
            value
          end
        end
      end
    end
  end
end
