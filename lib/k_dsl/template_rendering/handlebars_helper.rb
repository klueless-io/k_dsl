# Klue-Less DDD generator

module KDsl
  module TemplateRendering
    # https://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-humanize
    class HandlebarsHelper

      def self.register(handlebars)
        value_helpers(handlebars)
        conditional_helpers(handlebars)
        custom_helpers(handlebars)
      end

      def self.custom_helpers(handlebars)
        handlebars.register_helper(:custom_namespace_array) do |_context, value|
          result = value.split('-').map { |v| "'#{v.titleize}'" }.join(', ')

          Handlebars::SafeString.new(result)
        end
      end

      def self.conditional_helpers(handlebars)
        handlebars.register_helper(:ifx) do |context, v1, operator, v2, block|
          # puts "Type  (V1): #{v1.class.name}"
          # puts "Value (V1): #{v1}"
          # puts "Type  (operator): #{operator.class.name}"
          # puts "Value (operator): #{operator}"
          # puts "Type  (V2): #{v2.class.name}"
          # puts "Value (V2): #{v2}"

          if v1.is_a?(String) && v2.is_a?(String)
            v1.downcase!
            v2.downcase!
          end

          if 
            (operator == '==' && v1 == v2) ||
            (operator == '<'  && v1 < v2) ||
            (operator == '<=' && v1 <= v2) ||
            (operator == '>'  && v1 > v2) ||
            (operator == '>=' && v1 >= v2)
            block.fn(context)
          else
            block.inverse(context)
          end
        end
      end

      def self.parse_json(value, hash = {})
        if value.is_a?(V8::Array)
          return value.map { |item| parse_json(item) }
        end

        return KDsl::Util.data.struct_to_hash(value) if value.is_a?(OpenStruct)
        return value unless value.is_a?(V8::Object)

        value.keys.each do |key|
          case value[key].class.to_s
          when 'V8::Object'
            hash[key] = parse_json(value[key])
          when 'V8::Array'
            hash[key] = value[key].map do |item|
              if item.is_a?(V8::Object) || item.is_a?(V8::Array)
                parse_json(item)
              else
                item.values
              end
            end
          else
            hash[key] = value[key]
          end
        end

        hash
      end

      def self.value_helpers(handlebars)
        # TODO
        handlebars.register_helper(:raw) { |_context, block| 
          block.fn()
        }

        # TODO
        handlebars.register_helper(:safe) { |_context, value| 
          Handlebars::SafeString.new(value) 
        }

        # hello world = hello_world
        handlebars.register_helper(:snake) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.snake(value) 
        }

        # hello world = hello-world
        handlebars.register_helper(:dashify) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.dashify(value) 
        }

        # hello world = hello-world (alias: dashify)
        handlebars.register_helper(:dasherize) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.dashify(value) 
        }

        # hello world = HelloWorld (alias: camelU, camelUpper)
        handlebars.register_helper(:camel) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.camel(value) 
        }
        handlebars.register_helper(:camelU) { |_context, value| KDsl::TemplateRendering::HandlebarsFormatter.camel(value) }
        handlebars.register_helper(:camelUpper) { |_context, value| KDsl::TemplateRendering::HandlebarsFormatter.camel(value) }

        # hello world = helloWorld (alias: camelU, camelUpper)
        handlebars.register_helper(:lamel) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.lamel(value) 
        }
        handlebars.register_helper(:camelL) { |_context, value| KDsl::TemplateRendering::HandlebarsFormatter.lamel(value) }
        handlebars.register_helper(:camelLower) { |_context, value| KDsl::TemplateRendering::HandlebarsFormatter.lamel(value) }

        # hello world = Hello World (alias: titleize)
        handlebars.register_helper(:titleize) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.titleize(value) 
        }

        # hello world = Hello world (alias: humanize)
        handlebars.register_helper(:humanize) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.humanize(value) 
        }

        # hello world = HELLO_WORLD (alias: constant, constantize)
        handlebars.register_helper(:constant) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.constantize(value) 
        }
        handlebars.register_helper(:constantize) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.constantize(value) 
        }

        # hello world = hello/world
        handlebars.register_helper(:slash_forward) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.slash(value) 
        }
        handlebars.register_helper(:forward_slash) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.slash(value) 
        }
        handlebars.register_helper(:slash) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.slash(value) 
        }

        # hello world = hello\world
        handlebars.register_helper(:back_slash) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.back_slash(value) 
        }
        handlebars.register_helper(:backward_slash) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.back_slash(value) 
        }
        handlebars.register_helper(:slash_back) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.back_slash(value) 
        }
        
        # THIS NEEDS TO BE IN A RUBY NAMESPACE AREA
        # hello world = hello::world
        handlebars.register_helper(:double_colon) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.double_colon(value) 
        }
        handlebars.register_helper(:namespace) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.double_colon(value) 
        }

        # hello world = Hello world (alias: pluralize)
        handlebars.register_helper(:pluralize) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.pluralize(value) 
        }
        
        # Formats
        handlebars.register_helper(:format_as) { |_context, value, formats|
          if formats.is_a?(String)
            formats = formats.split(',').map(&:strip)
          end
          KDsl::TemplateRendering::HandlebarsFormatter.format_as(value, formats: formats)
        }
        
        # Default
        handlebars.register_helper(:default) { |_context, value, default_value| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.default(value, default_value)) 
        }
        
        # Padding
        handlebars.register_helper(:padr) { |_context, value, count| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.padr(value, count)) 
        }

        handlebars.register_helper(:padl) { |_context, value, count| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.padl(value, count)) 
        }

        # Surround if value
        handlebars.register_helper(:surround_if_value) { |_context, value, prepend, append, format|
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.surround_if_value(value, prepend, append, format)) 
        }
        handlebars.register_helper(:prefix_if_value) { |_context, value, prepend, format| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.prepend_if_value(value, prepend, format)) 
        }

        # Prepend if value
        handlebars.register_helper(:prepend_if_value) { |_context, value, prepend, format|
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.prepend_if_value(value, prepend, format)) 
        }
        handlebars.register_helper(:prefix_if_value) { |_context, value, prepend, format| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.prepend_if_value(value, prepend, format)) 
        }

        # Append if value
        handlebars.register_helper(:append_if_value) { |_context, value, append, format| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.append_if_value(value, append, format)) 
        }
        handlebars.register_helper(:suffix_if_value) { |_context, value, append, format| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.append_if_value(value, append, format)) 
        }

        # JSON
        handlebars.register_helper(:json) { |_context, value|
          Handlebars::SafeString.new(parse_json(value).to_json)
        }
        handlebars.register_helper(:keys) { |_context, value|
          Handlebars::SafeString.new(value.keys)
        }
        # handlebars.register_helper(:values) { |context|
        #   Handlebars::SafeString.new(context.values)
        # }
        # handlebars.register_helper(:bind) { |context|
        #   bind----ing.pry
        # }

        handlebars.register_helper(:repeat) { |_context, count, value|
          value = ' ' unless defined?(value)
          KDsl::TemplateRendering::HandlebarsFormatter.repeat(count, value)
        }

        # Hash
        handlebars.register_helper(:hash) { |_context, count|
          KDsl::TemplateRendering::HandlebarsFormatter.hash(count)
        }
        
        # Curly Open
        handlebars.register_helper(:curly_open) { |_context, count|
          KDsl::TemplateRendering::HandlebarsFormatter.curly_open(count)
        }
        handlebars.register_helper('curly-open') { |_context, count| KDsl::TemplateRendering::HandlebarsFormatter.curly_open(count) }

        # Curly Closed
        handlebars.register_helper(:curly_close) { |_context, count|
          KDsl::TemplateRendering::HandlebarsFormatter.curly_close(count)
        }
        handlebars.register_helper('curly-close') { |_context, count| KDsl::TemplateRendering::HandlebarsFormatter.curly_close(count) }

        handlebars.register_helper('or') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.or(lhs, rhs) }
        handlebars.register_helper('and') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.and(lhs, rhs) }
        handlebars.register_helper('eq') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.eq(lhs, rhs) }
        handlebars.register_helper('ne') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.ne(lhs, rhs) }
        handlebars.register_helper('lt') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.lt(lhs, rhs) }
        handlebars.register_helper('lte') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.lte(lhs, rhs) }
        handlebars.register_helper('gt') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.gt(lhs, rhs) }
        handlebars.register_helper('gte') { |_context, lhs, rhs| KDsl::TemplateRendering::HandlebarsFormatter.gt(lhs, rhs) }

        handlebars.register_helper(:debug_values) do |_context, data| 
          if data.is_a?(String)
            puts data
          elsif data.is_a?(V8::Object)
            puts data.values
          else
            puts 'WHO IS RICKY'
            puts data.class.name
          end
        end
        
        private_class_method :value_helpers
      end
    end
  end
end