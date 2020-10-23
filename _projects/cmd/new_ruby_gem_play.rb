# KDsl.cmd :cmd do
KDsl.document :ruby_gem_playground do
  gem_name = 'loquacious'
  gem_name = 'handlebars'

  s = settings do
    name                    "playrb_#{gem_name}"
    description_suffix      "is a Ruby playground project for understanding the #{gem_name.titleize} GEM"
    definition_subfolder    'ruby-gem'
    project_group           :kgems
    website_slug_group      'play-with-ruby'
  end

  s.website_slug = gem_name
  s.main_story   = "As a Developer, I want to understand what the #{gem_name.titleize} GEM is doing via example, so that I improve my skills with Ruby"

  actions do
    # new_microapp s.name,
    #   definition_subfolder: s.definition_subfolder,
    #   output_subfolder: "#{s.project_group}/#{s.name}",
    #   show_editor: true, 
    #   f: true,
    #   debug_only: false

    # write_json is_edit: true
  end
end
