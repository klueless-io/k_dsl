# KDsl.cmd :cmd do
KDsl.document :ruby_cmdlet do
  s = settings do
    name                    'k_xmen'
    description_suffix      "is a Ruby command line for"
    definition_subfolder    'ruby-cmdlet'
    project_group           :kcmd
    website_slug            'command-line-tool'
  end

  def on_action
    new_microapp s.name,
      definition_subfolder: s.definition_subfolder,
      output_subfolder: "#{s.project_group}/#{s.name}",
      show_editor: true, 
      f: false,
      debug_only: false

    # write_json is_edit: true
  end
end
