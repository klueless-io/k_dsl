# KDsl.cmd :cmd do
KDsl.document :ruby_gem do
  s = settings do
    # name                    'handlebars-helpers'
    # name                  'rspec-usecases'
    # name                    'webpack5-builder'
    # name                    'k_builder-dotnet'
    # name                    'k_util'
    # name                    'gpt3-builder'
    # name                    'funcky'
    # name                    'ruby-handlebars-helpers'
    # name                    'k_fileset'
    name                    'conventional_gitflow'
    description_suffix      'provides tools for conventional git workflows including changelogs and SemVer'
    # description_suffix      'provides file system snapshot using GLOB inclusions and exclusions'
    # description_suffix      'provides various fluent builders for building webpack configuration file'
    # description_suffix      'will watch k_builder files and when they change, execute them'
    # description_suffix      'provides base types for KlueLess code generation'
    # description_suffix      'provides a set of functions (wrapped in the command pattern) that perform simple actions'
    definition_subfolder    'ruby-gem'
    project_group           :kgems
    website_slug_group      :gems
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Developer, I want to get a log of conventional commits, so that I can build conventional CI flows such as SemVer and ChangeLogs"
  # s.main_story   = "As a Developer, I want a path/file snapshot files on a computer, so I can access and manipulate files matching my pattern"
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
