# Klue-Less DDD generator

module KDsl
  module TemplateRendering
    # https://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-humanize
    class HandlebarsFormatter

      # ----------------------------------------------------------------------
      #  format symbols
      # ----------------------------------------------------------------------

      # TODO
      def self.format_as(value, formats: [])
        formats.each do |format|
          value = format(value, format)
        end
        value
      end

      # TODO
      def self.format(value, format = nil)
        case format.to_s.to_sym
        when :snake
          return snake(value)
        when :dashify, :dasherize
          return dashify(value)
        when :camel, :camelU, :camelUpper
          return camel(value)
        when :lamel, :camelL, :camelLower
          return lamel(value)
        when :titleize
          return titleize(value)
        when :humanize
          return humanize(value)
        when :constant, :constantize
          return constantize(value)
        when :pluralize
          return pluralize(value)
        when :slash, :slash_forward, :forward_slash
          return slash(value)
        when :slash_back, :back_slash, :backward_slash, :slash_backward
          return back_slash(value)
        when :double_colon, :namespace
          return double_colon(value)
        end
        value
      end

      def self.snake(value)
        value = value.to_s

        value.parameterize.underscore
      end

      def self.slash(value)
        value = value.to_s

        value.parameterize(preserve_case: true).dasherize.gsub('-', '/')
      end

      def self.back_slash(value)
        value = value.to_s

        value.parameterize(preserve_case: true).dasherize.gsub('-', '\\')
      end

      def self.double_colon(value)
        value = value.to_s

        value.parameterize(preserve_case: true).dasherize.gsub('-', '::')
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

      def self.pluralize(value)
        value = value.to_s

        value.pluralize
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

      # Pad Right
      def self.padr(value, count = nil)
        # L.kv 'value', value
        # L.kv 'count', count
        count = defined?(count) && count.is_a?(Integer) ? count : 30
        value = '' if value.nil?
        out = value.ljust(count)
      end

      # Pad Left
      def self.padl(value, count = nil)
        # L.kv 'value', value
        # L.kv 'count', count
        count = defined?(count) && count.is_a?(Integer) ? count : 30
        value = '' if value.nil?
        out = value.rjust(count)
      end

      # STRING CASE
      # & 
      # STRING
      def self.surround_if_value(value, prepend, append, format = :none)
        # L.kv 'value', value
        # L.kv 'prepend', prepend
        # L.kv 'format', format
        value.present? ? "#{prepend}#{format(value, format)}#{append}" : ''
      end

      # STRING CASE
      # & 
      # STRING
      # prepend_if_value - will prepend a prepend to a value if the value is not empty
      def self.prepend_if_value(value, prepend, format = :none)
        # L.kv 'value', value
        # L.kv 'prepend', prepend
        # L.kv 'format', format
        value.present? ? "#{prepend}#{format(value, format)}" : ''
      end

      # append_if_value - will add a append to a value if the value is not empty
      def self.append_if_value(value, append, format = :none)
        # L.kv 'value', value
        # L.kv 'default_value', default_value
        value.present? ? "#{format(value, format)}#{append}" : ''
      end

      # STRING
      # append_if_value - will add a append to a value if the value is not empty
      def self.repeat(count, value = ' ')
        # L.kv 'value', value
        # L.kv 'count', count
        value * count
      end
      
      # STRING (LINE_HASH LINE_DASH LINE_UNDERSCORE)
      # hash
      def self.hash(count = 1)
        # L.kv 'count', count.class.name
        # L.kv 'count', count

        count = defined?(count) && count.is_a?(Integer) ? count : 1
        
        '#' * count
      end
      
      # TEMPLATE
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
