# frozen_string_literal: true

require 'thor'

module {{camelU settings.application}}
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', '{{snake settings.application}} version'
    def version
      require_relative 'version'
      puts 'v' + {{camelU settings.application}}::VERSION
    end
    map %w[--version -v] => :version

    desc 'toc', 'Table of contents'
    def toc
      require_relative 'commands/toc'
      {{camelU settings.application}}::Commands::Toc.new({}).execute
    end
    map %w[--toc] => :toc

    {{> commands_api}}
  end
end

{{#*inline "commands_api"}}
{{#each commands}}
#
# {{this.settings.name}}
#
desc '{{this.settings.name}} {{> argListCapital this}}', '{{this.settings.description}}'
method_option :help, aliases: '-h',
                     type: :boolean,
                     desc: 'Display usage information'
def {{this.settings.name}}{{#if args}}({{else}}{{/if}}{{> argList1 this}}{{#if args}}){{else}}{{/if}}
  if options[:help]
    invoke :help, ['{{this.settings.name}}']
  else
    require_relative 'commands/{{this.settings.name}}'
    {{camelU ../settings.application}}::Commands::{{camelU this.settings.name}}.new({{> argList2 this}}options).execute
  end
end
{{#if @last}}{{else}}
{{/if}}
{{/each}}
{{/inline}}
{{#*inline "argList1"}}
{{#each args}}{{this.name}}{{#ifx this.name '==' 'subcommand'}} = :gui{{/ifx}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{/inline}}
{{#*inline "argList2"}}
{{#each args}}{{this.name}}, {{/each}}{{/inline}}
{{#*inline "argListCapital"}}
{{#each args}}{{constantize this.name}}{{#if @last}}{{else}} {{/if}}{{/each}}{{/inline}}
