# KDsl.cmd :cmd do
KDsl.document :csharp_mvc do
  s = settings do
    name                    :p09_mvc_bootstrap_plugins
    description_suffix      'simple mvc app using bootstrap 5 and bootstrap plugins'
    definition_subfolder    'csharp-mvc'
    project_group           'c#'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a C# Developer, I want a simple MVC app with bootstrap plugins, so that I practice web apps"
  
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
