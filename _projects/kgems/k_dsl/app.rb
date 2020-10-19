# ------------------------------------------------------------
# MicroApp: Ruby Commandlet
# ------------------------------------------------------------

KDsl.microapp :k_dsl do
  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   'K Dsl is a Ruby GEM for '
    application                   'k_dsl'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'k_dsl'
    website                       'http://appydave.com/gems/k_dsl'
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/kgems/k_dsl'
    data_path                     '_/.data'

    base_path2                     ''
    app_path2                      '/k_dsl'
  end

  actions do
    new_blueprint 'extensions', definition_name: 'custom', definition_subfolder: 'ruby-gem', f: false, show_editor: true
  end

end
