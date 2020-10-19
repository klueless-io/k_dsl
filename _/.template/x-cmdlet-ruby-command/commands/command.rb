# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module {{camelU settings.application}}
  module Commands
    # Command Name goes here
    class {{camelU command.name}} < {{camelU settings.application}}::Command
      def initialize({{> argList}}options)
        {{> argAssignment}}

        @options = options
      end

      # Execute {{camelU command.name}} command taking input from a input stream
      # and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
      end
    end
  end
end
{{#*inline "argList"}}
{{#each args}}{{this.name}}, {{/each}}{{/inline}}

{{#*inline "argAssignment"}}
{{#each args}}@{{this.name}} = {{#ifx this.name '==' 'subcommand'}}({{../name}} || '').to_sym{{this.name}}{{else}}{{../name}}{{/ifx}}
{{/each}}{{/inline}}
