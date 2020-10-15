# Klue-Less DDD generator
require 'active_support/core_ext/string/inflections'

module KDsl
  module TemplateRendering
    # https://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-humanize
    class HandlebarsFormatter

      # ----------------------------------------------------------------------
      #  format symbols
      # ----------------------------------------------------------------------

      # snake
      def self.snake(value)
        value = value.to_s

        value.parameterize.underscore
      end

      def self.dashify(value)
        value = value.to_s

        value.parameterize.dasherize
      end

      def self.camel(value)
        value = value.to_s

        value.parameterize.underscore.camelize
      end

      def self.lamel(value)
        value = value.to_s

        value.parameterize.underscore.camelize(:lower)
      end

      def self.titleize(value)
        value = value.to_s

        value.parameterize.underscore.titleize
      end

      def self.humanize(value)
        value = value.to_s

        value.parameterize.underscore.humanize
      end

      def self.constantize(value)
        value = value.to_s

        snake(value).upcase
      end

      # ----------------------------------------------------------------------
      #  format symbols
      # ----------------------------------------------------------------------

      # default
      def self.default(value, default_value)
        # L.kv 'value', value
        # L.kv 'default_value', default_value
        out = value || default_value
      end

      # curly_open
      def self.curly_open(count = 1)
        # L.kv 'count', count.class.name
        # L.kv 'count', count

        count = defined?(count) && count.is_a?(Integer) ? count : 1
        
        '{' * count
      end

      # curly_close
      def self.curly_close(count = 1)
        # L.kv 'count', count.class.name
        # L.kv 'count', count

        count = defined?(count) && count.is_a?(Integer) ? count : 1
        
        '}' * count
      end

      # ----------------------------------------------------------------------
      #  Logic helpers
      # ----------------------------------------------------------------------
      def self.or(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs || rhs
      end

      def self.and(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs && rhs
      end

      def self.eq(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs == rhs
      end

      def self.ne(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs != rhs
      end

      def self.lt(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs < rhs
      end

      def self.gt(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs > rhs
      end

      def self.lte(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs <= rhs
      end

      def self.gte(lhs, rhs)
        # L.kv 'lhs', lhs
        # L.kv 'rhs', rhs
        lhs >= rhs
      end

    end
  end
end
