# KDsl.cmd :cmd do
KDsl.document :ruby_gem do
  s = settings do
    name                    'k_dsl'
    definition_subfolder    'ruby-gem'
    project_group           :kgems
    website_slug            :gems
  end

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
