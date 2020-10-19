# frozen_string_literal: true

require_relative '../command'

require 'tty-config'
require 'tty-prompt'

module {{camelU settings.application}}
  module Commands
    # Command Name goes here
    class {{camelU command.name}}{{camelU subcommand.name}} < {{camelU settings.application}}::Command
      def initialize({{> argList}}options)
        {{> argAssignment}}
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        data = list_{{snake command.name}}_by(mine: true, max_results: 50)

        print_all data

        # pretty_table('{{snake command.name}}',
        #              %w[column1 column2],
        #              data.map { |d| [d[:key1], d[:key2]] })
      end

      def list_{{snake command.name}}_by(part = 'snippet', **params)
        response = youtube.list_{{snake command.name}}(part, params).to_json
        data = JSON.parse(response)

        pretty data

        data.fetch('items').map { |i| mapper(i) }
      end

      def mapper(item)
        {
          etag: item.dig('etag'),
          # kind: item.dig('id', 'kind'),
          # title: item.dig('snippet', 'title'),
          # description: item.dig('snippet', 'description'),
          # published_at: item.dig('snippet', 'publishedAt'),
          # thumbnail_default: item.dig('snippet', 'thumbnails', 'default', 'url'),
          # thumbnail_high: item.dig('snippet', 'thumbnails', 'high', 'url'),
          # thumbnail_medium: item.dig('snippet', 'thumbnails', 'medium', 'url'),
          # channel_id: item.dig('snippet', 'channelId'),
          # channel_title: item.dig('snippet', 'channelTitle')
        }
      end
    end
  end
end
{{#*inline "argList"}}
{{#each args}}{{this.name}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{/inline}}

{{#*inline "argAssignment"}}
{{#each args}}@{{this.name}} = {{#ifx this.name '==' 'subcommand'}}({{../name}} || '').to_sym{{this.name}}{{else}}{{../name}}{{/ifx}}
{{/each}}{{/inline}}
