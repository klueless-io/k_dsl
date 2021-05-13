# KDsl.cmd :cmd do
KDsl.document :rails do
  s = settings do
    name                    'printspeakx'
    description_suffix      'provides a sample rails 6 application for the Printspeak enterprise'
    definition_subfolder    'rails'
    project_group           :rails
    website_slug_group      :rails
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Printing Franchise, I need to market my business, so I can generate more business"
  
  def on_action
    s = d.settings
    new_microapp s.name,
      definition_subfolder: s.definition_subfolder,
      output_subfolder: "#{s.project_group}/#{s.name}",
      show_editor: true, 
      f: true,
      debug_only: false

    # write_json is_edit: true
  end
end
