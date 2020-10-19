# ------------------------------------------------------------
# MicroApp: Ruby Commandlet
# ------------------------------------------------------------

KDsl.microapp :k_xmen do
  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Commandlet'
    description                   'K Xmen is a command line tool for '
    application                   'k_xmen'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'k_xmen'
    website                       'http://appydave.com/tool/k_xmen'
    main_story                    'As a Developer, I should be able to something cool, so that I am more efficient'
    app_path                      '~/dev/cmdlets/k_xmen'
    data_path                     '_/.data'

    github_user                   parent.project.config.github_user
    github_personal_access_token  parent.project.config.github_personal_access_token

  end

  actions do
    new_github_repo s.name
    # Definition and Template folders should come from specific settings areas within the microap
    # new_structure 'bootstrap' , definition_subfolder: 'ruby-cmdlet', f: true, show_editor: true
    # new_structure 'stories'   , definition_subfolder: 'ruby-cmdlet', output_subfolder: :k_xmen, f: false, show_editor: true

    # new_structure 'commands', definition_name: 'ruby_cmdlet_commands', f: true

    # new_archetype :config, :command, definition_name: 'ruby_cmdlet_command_main', f: true
    # new_archetype :basic_command, :command, definition_name: 'ruby_cmdlet_command', f: true
    # new_archetype :main_menu_command, :command, definition_name: 'ruby_cmdlet_command_main', f: true

    # new_entity :command, definition_name: 'cmdlet_command_list', description: 'represents the commands that will be available for this cmdlet', f: true
  end

end
