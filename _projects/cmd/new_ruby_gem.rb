# KDsl.cmd :cmd do
KDsl.document :ruby_gem do
  s = settings do
    name                    'k_dsl'
    description_suffix      'is a Ruby GEM for'
    definition_subfolder    'ruby-gem'
    project_group           :kgems
    website_slug_group      :gems
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Developer, I should be able to, so that I"
  
  actions do
    new_microapp s.name,
      definition_subfolder: s.definition_subfolder,
      output_subfolder: "#{s.project_group}/#{s.name}",
      show_editor: true, 
      f: false,
      debug_only: false

    # write_json is_edit: true
  end
end
