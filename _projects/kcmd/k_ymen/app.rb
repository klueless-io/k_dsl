# ------------------------------------------------------------
# MicroApp: Ruby Commandlet
# ------------------------------------------------------------

KDsl.microapp :k_ymen do
  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Commandlet'
    description                   'K Ymen is a command line tool for '
    application                   'k_ymen'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'k_ymen'
    website                       'http://appydave.com/tool/k_ymen'
    main_story                    'As a XX, I should be able to , so that I'
    app_path                      '~/dev/cmdlets/k_ymen'
    data_path                     '_/.data'
    github_user                   parent.project.config.github_user
    github_repo                   'k_ymen'
  end

  actions do
    new_github_repo s.name
    # delete_github_repo s.name
    
    # ToDo: Definition and Template folders should come from specific settings areas within the microap
    new_structure 'bootstrap' , definition_subfolder: 'ruby-cmdlet', microapp: self.data, f: true, show_editor: true
    # new_structure 'stories'   , definition_subfolder: 'ruby-cmdlet', f: true, show_editor: true

    # new_structure 'commands', definition_name: 'ruby_cmdlet_commands', f: true

    # new_archetype :config, :command, definition_name: 'ruby_cmdlet_command_main', f: true
    # new_archetype :basic_command, :command, definition_name: 'ruby_cmdlet_command', f: true
    # new_archetype :main_menu_command, :command, definition_name: 'ruby_cmdlet_command_main', f: true

    # new_entity :command, definition_name: 'cmdlet_command_list', description: 'represents the commands that will be available for this cmdlet', f: true
  end

end
