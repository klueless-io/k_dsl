# frozen_string_literal: true

# require '{{microapp.settings.application_lib_path}}{{prefix_if_value blueprint.settings.output_rel_path '/' 'snake'}}/{{snake blueprint.settings.name}}'

{{#each microapp.settings.application_lib_namespaces}}module {{.}}
{{/each}}{{#if blueprint.settings.output_rel_path}}
  module {{camel blueprint.settings.output_rel_path}}{{/if}}
    # {{titleize blueprint.settings.name}}
    class {{camel blueprint.settings.name}}
      {{model_attributes}}
      def initialize
      end

      {{{model_debug}}}
    end{{#if blueprint.settings.output_rel_path}}
  end{{/if}}
{{#each microapp.settings.application_lib_namespaces}}end
{{/each}}
