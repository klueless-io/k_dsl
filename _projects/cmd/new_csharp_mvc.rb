# KDsl.cmd :cmd do
KDsl.document :csharp_mvc do
  s = settings do
    name                    :p11_club_membership
    description_suffix      'Membership management system for a Sydney Club'
    definition_subfolder    'csharp-mvc'
    project_group           'c#'
    website_slug_group      'csharp/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Club Owner, I want to record and find member details, so I know who is in my club"
  
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
