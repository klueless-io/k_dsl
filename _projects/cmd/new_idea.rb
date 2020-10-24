# KDsl.cmd :cmd do
KDsl.document :idea do
  s = settings do
    name                    'spiders' # 'speechelo_automation'
    definition_subfolder    'idea'
    project_group           :idea
    website_slug            :idea
    new_app_type            :cmdlet # :ruby_pattern :spidy_robot
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
