# frozen_string_literal: true

# require 'peeky{{prefix_if_value blueprint.settings.output_rel_path '/' 'snake'}}/{{snake blueprint.settings.name}}'

module Peeky{{#if blueprint.settings.output_rel_path}}
  module {{camel blueprint.settings.output_rel_path}}{{/if}}
    # {{titleize blueprint.settings.name}}
    class {{camel blueprint.settings.name}}
      attr_reader :xxx
      def initialize(xxx)
        @xxx = xxx
      end

      def render
      end

      def debug
        puts render
      end
    end{{#if blueprint.settings.output_rel_path}}
  end{{/if}}
end
