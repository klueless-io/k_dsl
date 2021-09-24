# KDsl.cmd :cmd do
KDsl.document :ruby_gem do
  s = settings do
    # name                    'handlebars-helpers'
    # name                  'rspec-usecases'
    # name                    'webpack5-builder'
    # name                    'k_builder-dotnet'
    # name                    'k_util'
    name                    'gpt3-builder'
    # description_suffix      'provides Nx handlebars helpers across Ny categories'
    # description_suffix      'provides various fluent builders for building webpack configuration file'
    # description_suffix      'will watch k_builder files and when they change, execute them'
    # description_suffix      'provides base types for KlueLess code generation'
    description_suffix      'provides builder pattern for creating GTP3 questions and answers against OPENAI'
    definition_subfolder    'ruby-gem'
    project_group           :kgems
    website_slug_group      :gems
  end
  
  s.website_slug = s.name
  s.main_story   = "As a Developer, I need to workout how the openai gpt3 works, so I can implement ML"
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
