# KDsl.cmd :cmd do
KDsl.document :webpack do
  s = settings do
    name                    :html_multi_page
    description_suffix      'using Webpack 5'
    definition_subfolder    'webpack5'
    project_group           :webpack5
    website_slug_group      'webpack5/by-example'
  end
  
  s.website_slug = s.name
  # s.main_story   = "As a SPA Developer, I want a flexible build pipeline, so that I automate common tasks"
  s.main_story   = "As a SPA Developer, I want to have multiple html pages with separated assets, so that I can build a multi page site"
  
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
