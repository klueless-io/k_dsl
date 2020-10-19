# frozen_string_literal: true

{{#each main_requires}}
require '{{snake ../settings.application}}/{{this}}'
{{/each}}

# Main commands
{{#each commands}}
require '{{snake ../settings.application}}/commands/{{snake this.settings.name}}'
{{/each}}

# Main entry file for requiring child dependencies
module {{camelU settings.application}}
  # class Error < StandardError; end
end

