# KDsl.cmd :cmd do
KDsl.document :react_native do
  s = settings do
    name                    :r02_navigation
    description_suffix      ''
    definition_subfolder    'react-native'
    project_group           :react_native
    website_slug_group      'react-native/samples'
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Developer, I want to create my first React Native App from template, so that I can do mobile programming"
  
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
