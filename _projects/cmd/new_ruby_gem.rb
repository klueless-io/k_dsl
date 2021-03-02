# KDsl.cmd :cmd do
KDsl.document :ruby_gem do
  s = settings do
    # name                    'handlebars-helpers'
    # name                  'rspec-usecases'
    name                    'webpack5-builder'
    # description_suffix      'provides Nx handlebars helpers across Ny categories'
    description_suffix      'provides simple commands for building up package.json and webpack.config for a webpack5 project'
    definition_subfolder    'ruby-gem'
    project_group           :kgems
    website_slug_group      :gems
  end
  
  s.website_slug = s.name
  s.main_story   = "As a SPA Developer, I want to configure webpack5 enabled applications quickly, so I don't have to be a WebPack5 expert"
  # s.main_story   = "As a Ruby Developer, I want to use HandlebarsJS with useful helpers, so that I have a rich templating experience"
  
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
