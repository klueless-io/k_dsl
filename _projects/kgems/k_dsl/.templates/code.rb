# frozen_string_literal: true

# require 'k_dsl/{{snake blueprint.settings.output_rel_path}}/{{snake blueprint.settings.name}}'

module KDsl
  module {{camel blueprint.settings.output_rel_path}}
    # {{titleize blueprint.settings.name}}
    class {{camel blueprint.settings.name}}
      {{instruction.properties}}

      def initialize
      end
    end
  end
end