# KDsl.cmd :cmd do
KDsl.document :html do
  s = settings do
    name                    :l04_transpiler_swc
    description_suffix      'in HTML'
    definition_subfolder    'html'
    project_group           :html
    website_slug_group      'html/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Javascript Developer, I want to target the latest ES features while maintaining browser compatibility, so that I can code fast but support older browsers"
  
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
