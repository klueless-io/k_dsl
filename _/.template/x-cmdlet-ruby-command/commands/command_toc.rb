# frozen_string_literal: true

require_relative '../command'
require_relative '../exit_app'

require 'tty-config'
require 'tty-prompt'

module {{camelU settings.application}}
  module Commands
    # Table of contents command
    class Toc < {{camelU settings.application}}::Command
      def initialize(options)
        @options = options
      end

      # Execute {{camelU command.name}} command taking input from a input stream
      # and writing to output stream
      #
      # sample: output.puts 'OK'
      def execute(input: $stdin, output: $stdout)
        {{> selectCommands}}
      end

      private

      def gui
        prompt = TTY::Prompt.new

        choices = [
          {{> commandEnums}}
        ]

        begin
          prompt.on(:keyctrl_x, :keyescape) do
            raise ExitApp
          end

          command = prompt.select('Select your command?', choices, per_page: 15, filter: true, cycle: true)

          command.to_sym
        rescue {{camelU settings.application}}::ExitApp
          puts
          puts
          prompt.warn 'exiting....'
          puts
          :exit
        end

      end
    end
  end
end
{{#*inline "selectCommands"}}
{{#if commands}}
loop do
  case @command
  {{#each commands}}
  when :{{snake this.settings.name}}
    require_relative '{{snake this.settings.name}}'
    cmd = {{camelU ../settings.application}}::Commands::{{camelU this.settings.name}}{{camelU this.name}}.new('gui', {})
    @command = cmd&.execute(input: input, output: output)
  {{/each}}
  when :exit
    break
  else
    @command = gui
  end
  
end
{{/if}}
{{/inline}}

{{#*inline "commandEnums"}}
{{#each commands}}
{ value: '{{snake this.settings.name}}', name: '{{titleize this.settings.name}}' }{{#if @last}}{{else}}, {{/if}}
{{/each}}
{{/inline}}
