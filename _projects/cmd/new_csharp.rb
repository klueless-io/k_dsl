# KDsl.cmd :cmd do
KDsl.document :csharp_mvc do
  s = settings do
    name                    :p15_areas
    description_suffix      'Areas and routing'
    definition_subfolder    'csharp-mvc'
    project_group           'csharp'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Movie Theatre Owner, I want sell ticket to different sessions, so that I can make money"
  
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
