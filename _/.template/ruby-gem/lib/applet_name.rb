# frozen_string_literal: true

require '{{microapp.settings.application_lib_path}}/version'

{{#each microapp.settings.application_lib_namespaces}}
module {{.}}
{{/each}}

  # raise {{microapp.settings.application_lib_namespace}}::Error, 'Sample message'
  class Error < StandardError; end
  
  # Your code goes here...

{{#each microapp.settings.application_lib_namespaces}}
end
{{/each}}
  
