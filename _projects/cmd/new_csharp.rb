# KDsl.cmd :cmd do
KDsl.document :csharp_mvc do
  s = settings do
    name                    :pitstop
    description_suffix      'Based on ideas from EdwinVW/pitstop, this repo re-imagines the Garage Management System for Pitstop - a fictitious garage / car repair shop.'
    definition_subfolder    'csharp-mvc'
    project_group           'csharp'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a C# Developer, I want a simple MVC application, so that I practice web apps"
  
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
