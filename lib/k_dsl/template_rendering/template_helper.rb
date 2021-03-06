# Klue-Less DDD generator
require 'handlebars'

module KDsl
  module TemplateRendering
    class TemplateHelper

      def self.process_template(template, data)
        # L.block 'process template'
    
        handlebars = Handlebars::Context.new

        KDsl::TemplateRendering::HandlebarsHelper.register(handlebars)
        
        compiled_template = handlebars.compile(template)
    
        # L.ostruct data#, skip_array: true

        begin

          # REFACT: Array and Hash need to be looked at
          if data.is_a?(Array)
            obj = data.map do |item|
              o = item.to_h

              o.keys.each do |key|
                o[key] = o[key].to_h if o[key].class == OpenStruct
              end

              o
            end
          else
            obj = data.to_h

            obj.keys.each do |key|
              obj[key] = obj[key].to_h if obj[key].class == OpenStruct
            end
          end
    
          output = compiled_template.call(obj)
        rescue StandardError => e
          L.block 'Failed to process template', e.message
          L.exception e
        end
    
        process_cr_token(output.strip)
      end
    
      def self.process_cr_token(content)
        # Look for Carriage Return token, followed by the count of those tokens at the end of the string
        # $CR12$
        # equals
        # 12 carriage returns
        # regex = /\$(?<token>CR)(?<count>[\d]*)\$\z/
        # m = content.match(regex)
        # if m
        #   L.kv 'COUNT', m[:count].to_i
        #   carriage_returns = ("\n" * m[:count].to_i)
        #   content = content.gsub(regex, carriage_returns)
        # end
        content + "\n"
      end
    end
  end
end