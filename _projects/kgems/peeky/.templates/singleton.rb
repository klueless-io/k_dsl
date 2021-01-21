# frozen_string_literal: true

# require 'peeky{{prefix_if_value snake blueprint.settings.output_rel_path '/'}}/{{snake blueprint.settings.name}}'

module Peeky{{#if blueprint.settings.output_rel_path}}
  module {{camel blueprint.settings.output_rel_path}}{{/if}}
    # {{titleize blueprint.settings.name}}
    class {{camel blueprint.settings.name}}
      {{instruction.properties}}

      def initialize
      end
      private_class_method :new

      def self.create()
        new()
      end
     end{{#if blueprint.settings.output_rel_path}}
  end{{/if}}
end
