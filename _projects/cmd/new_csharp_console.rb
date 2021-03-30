# KDsl.cmd :cmd do
KDsl.document :csharp_mvc do
  s = settings do
    name                    :p06_sales_terminal
    description_suffix      'domain model for a shop with cash registers'
    definition_subfolder    'csharp-mvc'
    project_group           'c#'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a C# Developer, I want to model a shot with cash registers, so that I practice domain modeling"
  
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
