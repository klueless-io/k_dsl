# KDsl.cmd :cmd do
KDsl.document :react do
  s = settings do
    name                    :r06_monopoly
    description_suffix      ''
    definition_subfolder    'react'
    project_group           :react
    website_slug_group      'react/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Monopoly Player, I want a beautiful UX to play monopoly on, so that I am an engaged player"
  
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
