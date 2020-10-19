# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module {{camelU settings.application}}
  module Commands
    # {{subcommand.description}}
    class {{camelU command.name}}{{camelU subcommand.name}} < {{camelU settings.application}}::Command
      def initialize({{> argList}}options)
        {{> argAssignment}}
        super(options)
      end

      # Execute {{camelU command.name}}{{camelU subcommand.name}} subcommand taking input from
      # a input stream and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        :gui
      end
    end
  end
end
{{#*inline "argList"}}
{{#each args}}{{this.name}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{/inline}}

{{#*inline "argAssignment"}}
{{#each args}}@{{this.name}} = {{#ifx this.name '==' 'subcommand'}}({{../name}} || '').to_sym{{this.name}}{{else}}{{../name}}{{/ifx}}
{{/each}}{{/inline}}
