# KDsl.cmd :cmd do
KDsl.document :html do
  s = settings do
    name                    :l07_monopoly_board
    description_suffix      'in HTML'
    definition_subfolder    'html'
    project_group           :html
    website_slug_group      'html/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Monopoly Player, I want a nice monopoly board in CSS, so that I feel lie I am playing the game"
  
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
