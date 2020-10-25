Klue.microapp :k_dsl do

  s = settings do
    ruby_version                  '2.7.1'

    name                          kp.k_key.to_s
    app_type                      'Ruby Gem'
    description                   "KDSL 'k_dsl' is ruby gem for name/value and tabular data DSL generation"
    application                   'k_dsl'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'k_dsl'
    website                       'http://appydave.com/gems/k_dsl'
    main_story                    'As a Developer, I should be able to implement a flexible DSL quickly, so that I build my own Domain Language'
    base_path                     '~/dev/gems'
    app_path                      '~/dev/gems/k_dsl'
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

  def on_action
    # Support for
    #  - RuboCop
    #  - Guard
    #  - Different Logging Levels in Unit Test
    #  - Third Party Logging System that is only needed during test and debug


    new_structure 'setup', definition_name: 'ruby_gem_setup', f: true

    # write_json is_edit: true
  end

  table :stories do
    fields [:story, :tasks, f(:active, true)]

    row s.main_story,
        [
          'Create new gem', 
          'Setup deployment pipeline',
          'Setup guard and unit tests'
        ]

    # row 'As a Developer, I should be able to , so that I',
    #     []

    # row 'As a Developer, I should be able to , so that I',
    #     []

    # row 'As a Developer, I should be able to , so that I',
    #     []
  end

  # write_json is_edit: true

end
