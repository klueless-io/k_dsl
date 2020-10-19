# ------------------------------------------------------------
# MicroApp: Ruby Commandlet
# ------------------------------------------------------------

KDsl.microapp :k_zmen do
  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Commandlet'
    description                   'K Zmen is a command line tool for '
    application                   'k_zmen'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'k_zmen'
    website                       'http://appydave.com/tool/k_zmen'
    main_story                    'As a XX, I should be able to , so that I'
    app_path                      '~/dev/cmdlets/k_zmen'
    data_path                     '_/.data'
    github_user                   parent.project.config.github_user
    github_repo                   'k_zmen'
  end

  actions do
    # L.error 'david'
    # new_github_repo s.name
    # delete_github_repo s.name
    
    # ToDo: Definition and Template folders should come from specific settings areas within the microap
    new_structure 'bootstrap' , definition_subfolder: 'ruby-cmdlet', f: false, show_editor: true
    # new_structure 'stories'   , definition_subfolder: 'ruby-cmdlet', f: false, show_editor: true

    # new_structure 'commands', definition_name: 'ruby-cmdlet_commands', f: true

    # new_archetype :config, :command, definition_name: 'ruby-cmdlet_command_main', f: true
    # new_archetype :basic_command, :command, definition_name: 'ruby-cmdlet_command', f: true
    # new_archetype :main_menu_command, :command, definition_name: 'ruby-cmdlet_command_main', f: true

    # new_entity :command, definition_name: 'cmdlet_command_list', description: 'represents the commands that will be available for this cmdlet', f: true
  end

end
