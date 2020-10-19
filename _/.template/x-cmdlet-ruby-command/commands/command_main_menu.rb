# frozen_string_literal: true

require_relative '../command'
require_relative '../exit_app'

require 'tty-config'
require 'tty-prompt'

module {{camelU settings.application}}
  module Commands
    # Command Name goes here
    class {{camelU command.name}} < {{camelU settings.application}}::Command
      def initialize({{> argList}}options)
        {{> argAssignment}}
        super(options)
      end

      # Execute {{camelU command.name}} command taking input from a input stream
      # and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        {{> selectSubcommands}}
      end

      private

      def gui
        prompt = TTY::Prompt.new

        choices = [
          {{> subcommandEnums}}
        ]

        begin
          prompt.on(:keyctrl_x, :keyescape) do
            raise ExitApp
          end

          subcommand = prompt.select('Select your subcommand (ESC to Exit)?', choices, per_page: 15, filter: true, cycle: true)

          command = {{camelU settings.application}}{{camelU this.name}}::Commands::{{camelU command.name}}.new(subcommand, {})
          command.execute(input: @input, output: @output)
        rescue {{camelU settings.application}}::ExitApp
          puts
          prompt.warn 'go up one menu....'
          @subcommand = nil
        end
      end
    end
  end
end
{{#*inline "argList"}}
{{#each args}}{{this.name}}, {{/each}}{{/inline}}

{{#*inline "argAssignment"}}
{{#each args}}@{{this.name}} = {{#ifx this.name '==' 'subcommand'}}({{../name}} || '').to_sym{{this.name}}{{else}}{{../name}}{{/ifx}}
{{/each}}{{/inline}}

{{#*inline "selectSubcommands"}}
{{#if subcommands}}
loop do
  case @subcommand
  when :gui
    gui
  {{#each subcommands}}
  when :{{snake this.name}}
    require_relative '{{snake ../command.name}}_{{snake this.name}}'
    subcmd = {{camelU ../settings.application}}::Commands::{{camelU ../command.name}}{{camelU this.name}}.new({})
  {{/each}}
  else
    break
  end
  @subcommand = subcmd&.execute(input: input, output: output)
end
{{/if}}
{{/inline}}

{{#*inline "subcommandEnums"}}
{{#each subcommands}}
{ value: '{{snake this.name}}', name: '{{titleize this.name}}' }{{#if @last}}{{else}}, {{/if}}
{{/each}}
{{/inline}}
