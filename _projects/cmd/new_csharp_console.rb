# KDsl.cmd :cmd do
KDsl.document :csharp_console do
  s = settings do
    name                    :p04_domain_monopoly_v1
    description_suffix      'domain model for the monopoly game V1'
    definition_subfolder    'csharp-console'
    project_group           'c#'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a C# Developer, I want to model a simple Monopoly game, so that I practice domain modeling"
  
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
