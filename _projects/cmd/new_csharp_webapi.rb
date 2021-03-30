# KDsl.cmd :cmd do
KDsl.document :csharp_webapi do
  s = settings do
    name                    :p07_weather_microservice
    description_suffix      'simple webapi app with responsive page'
    definition_subfolder    'csharp-webapi'
    project_group           'c#'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a C# Developer, I want a simple WebApi to lookup Weather service, so that I practice web apps"
  
  def on_action
    s = d.settings
    new_microapp s.name,
      definition_subfolder: s.definition_subfolder,
      output_subfolder: "#{s.project_group}/#{s.name}",
      show_editor: true, 
      f: false,
      debug_only: false

    # write_json is_edit: true
  end
end
