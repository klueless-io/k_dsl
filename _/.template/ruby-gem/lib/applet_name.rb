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

if ENV['KLUE_DEBUG']&.to_s&.downcase == 'true'
  namespace = '{{camelU microapp.settings.application}}::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('{{microapp.settings.application_lib_path}}/version') }
  version   = {{camelU microapp.settings.application}}::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end

  
