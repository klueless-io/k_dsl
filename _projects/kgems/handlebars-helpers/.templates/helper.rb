# frozen_string_literal: true

# reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/methods.rb
require 'active_support/core_ext/string'

require '{{blueprint.settings.base_class_require}}'

module Handlebars
  module Helpers
    # {{blueprint.settings.category_description}}
    module {{camel blueprint.settings.category}}
      # {{safe blueprint.settings.description}}
      class {{camel blueprint.settings.name}} < {{blueprint.settings.base_class}}
        # Parse will {{safe blueprint.settings.description}}
        #
        # @example
        #
        {{#if blueprint.settings.example_input_value}}
        {{> simple_example}}
        {{^}}
        {{> smart_example}}
        {{/if}}
        #
        {{#each blueprint.settings.test_case.params}}
        # @param [{{type}}] {{name}} - {{description}}
        {{/each}}
        # @return [String] {{safe blueprint.settings.result}}
        def parse({{#each blueprint.settings.test_case.params}}{{name}}{{#if @last}}{{else}}, {{/if}}{{/each}})
          # code goes here
        end

        {{#if blueprint.settings.example_input_value}}
        {{> simple_def_handlebars_helper}}
        {{^}}
        {{> smart_def_handlebars_helper}}
        {{/if}}
      end
    end
  end
end
{{#*inline "simple_example"}}
#   puts {{camel blueprint.settings.name}}.new.parse('{{blueprint.settings.example_input_value}}')
#
#   {{blueprint.settings.example_output_value}}
{{/inline}}
{{#*inline "smart_example"}}
#   puts {{camel blueprint.settings.name}}.new.parse({{#each blueprint.settings.test_case.params}}'{{sample_value}}'{{#if @last}}{{else}}, {{/if}}{{/each}})
#
#   {{blueprint.settings.test_case.example_output_value}}
{{/inline}}
{{#*inline "simple_def_handlebars_helper"}}
# Sample handlebars registration helper
# def handlebars_helper
#   proc { |_context, value| parse(value) }
# end
{{/inline}}
{{#*inline "smart_def_handlebars_helper"}}
def handlebars_helper
  proc { |_context, {{#each blueprint.settings.test_case.params}}{{name}}{{#if @last}}{{else}}, {{/if}}{{/each}}| parse({{#each blueprint.settings.test_case.params}}{{name}}{{#if @last}}{{else}}, {{/if}}{{/each}}) }
end
{{/inline}}
