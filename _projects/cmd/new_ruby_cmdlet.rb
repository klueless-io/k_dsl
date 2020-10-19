# KDsl.cmd :cmd do
KDsl.document :ruby_cmdlet do
  s = settings do
    name                    'k_zmen'
    definition_subfolder    'ruby-cmdlet'
    project_group           :kcmd
    website_slug            :tool
  end

  actions do
    new_microapp s.name,
      definition_subfolder: s.definition_subfolder,
      output_subfolder: "#{s.project_group}/#{s.name}",
      show_editor: true, 
      f: true,
      debug_only: false

    # write_json is_edit: true
  end
end
