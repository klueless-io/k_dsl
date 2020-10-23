# Klue-Less DDD generator

module KDsl
  module TemplateRendering
    # https://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-humanize
    class HandlebarsHelper

      def self.register(handlebars)
        value_helpers(handlebars)
        conditional_helpers(handlebars)
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

      def self.value_helpers(handlebars)
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

        # hello world = Hello world (alias: pluralize)
        handlebars.register_helper(:pluralize) { |_context, value| 
          KDsl::TemplateRendering::HandlebarsFormatter.pluralize(value) 
        }
        
        # Default
        handlebars.register_helper(:default) { |_context, value, default_value| 
          Handlebars::SafeString.new(KDsl::TemplateRendering::HandlebarsFormatter.default(value, default_value)) 
        }

        # JSON
        # handlebars.register_helper(:json) { |_context, value|
        #   Handlebars::SafeString.new(value.to_json)
        # }
        handlebars.register_helper(:keys) { |_context, value|
          Handlebars::SafeString.new(value.keys)
        }
        # handlebars.register_helper(:values) { |context|
        #   Handlebars::SafeString.new(context.values)
        # }
        # handlebars.register_helper(:bind) { |context|
        #   bind----ing.pry
        # }
        
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