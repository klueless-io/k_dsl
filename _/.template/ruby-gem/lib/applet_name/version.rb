# frozen_string_literal: true

{{#each microapp.settings.application_lib_namespaces}}
module {{.}}
{{/each}}
  VERSION = '0.0.1'
{{#each microapp.settings.application_lib_namespaces}}
end
{{/each}}
