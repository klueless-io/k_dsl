Klue.microapp :{{snake name}} do

  # cmdlets_{{snake name}}: {
  #   name: "Cmdlet: {{titleize name}}" 
  # }

  # CURRENT_RUNNER = :cmdlets_{{snake name}}

  # Klue.register(File.join(Rails.root, '_')) do
  #   L.block "Register for #{CURRENT_RUNNERS[CURRENT_RUNNER][:name]}"

  #   register_path('microapp/_cmds/**/*.rb')

  #   register_path('microapp/_common/**/*.rb')
  #   register_path('microapp/cmdlets/{{snake name}}/**/*.rb')
  # end if CURRENT_RUNNER == :cmdlets_{{snake name}}

  s = settings do
    ruby_version                  '2.6.5'

    name                          kp.k_key.to_s
    app_type                      'Ruby Commandlet'
    description                   '{{titleize name}} is a command line tool for '
    application                   '{{snake name}}'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/XXX/{{snake name}}'
    main_story                    'As a XX, I should be able to , so that I'
    app_path                      '~/dev/cmdlets/{{snake name}}'
    data_path                     '_/.data'

    bitbucket_account             ENV['BITBUCKET_ACCOUNT'].to_s
    bitbucket_user                ENV['BITBUCKET_USER'].to_s
    github_user                   ENV['GITHUB_USER'].to_s

    # The following settings are only used in scripts, they do not get 
    # evaluated here and so you cannot rely on the values with ordinary templates
    bash_bitbucket_account        '${BITBUCKET_ACCOUNT}'
    bash_bitbucket_user           '${BITBUCKET_USER}'
    bash_github_user              '${GITHUB_USER}'
    bash_github_create_env_key    '${GITHUB_CREATE_REPO_TOKEN}'
    bash_github_delete_env_key    '${GITHUB_DELETE_REPO_TOKEN}'
  end

  actions do
    new_structure 'setup', definition_name: 'ruby_cmdlet_setup', f: true
    
    # new_structure 'commands', definition_name: 'ruby_cmdlet_commands', f: true
    
    # new_archetype :config, :command, definition_name: 'ruby_cmdlet_command_main', f: true

    # new_archetype :basic_command, :command, definition_name: 'ruby_cmdlet_command', f: true
    # new_archetype :main_menu_command, :command, definition_name: 'ruby_cmdlet_command_main', f: true

    # new_entity :command, definition_name: 'cmdlet_command_list', description: 'represents the commands that will be available for this cmdlet', f: true
  end

  table :stories do
    fields [:story, :tasks, f(:active, true)]

    row s.main_story,
        [
          'Create new commandline tool', 
          'Setup deployment pipeline',
          'Setup guard and unit tests'
        ]

    row 'As a XX, I should be able to , so that I',
        []

    # row 'As a Developer, I should be able to , so that I',
    #     []

    # row 'As a Developer, I should be able to , so that I',
    #     []

    # row 'As a Developer, I should be able to , so that I',
    #     []
  end

  # write_json is_edit: true

end
