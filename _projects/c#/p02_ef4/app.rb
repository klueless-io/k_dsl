# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :p02_ef4 do
  settings do
    name                          parent.key
    app_type                      'C# Console app'
    description                   'P02 Ef4 samples for using entity framework code first with SqlServer and Postgres'
    application                   'P02Ef4'
    git_repo_name                 'P02Ef4'
    git_organization              'klueless-csharp-samples'
    avatar                        'C# Developer'
    main_story                    'As a C# Developer, I want EF4 samples that interact with MS SQL and Postgres, so that I understand how to implement in my own projects'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/csharp/samples/p02-ef4'
    application_lib_path          'P02Ef4'
    template_rel_path             'csharp-console'
    app_path                      '~/dev/c#/P02Ef4'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_new_repo s.git_repo_name, organization: 'klueless-csharp-samples'
    # run_command 'dotnet new console -o git_repo_name'
    # run_command 'code .'

    # Add support for MS Sql and Postgres via EF4
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.SqlServer'
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.Design'
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.Tools'
    # run_command 'dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL'
    # run_command 'dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL.Design'

    # new_blueprint :bootstrap_bin_hook       , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: false, show_editor: true
    # new_blueprint :bootstrap_upgrade        , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_02_upgrade.rb' , f: false, show_editor: true
    # new_blueprint :bootstrap_github_actions , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_03_github_actions.rb' , f: false, show_editor: true
    # new_blueprint :basic_class              , definition_subfolder: 'ruby-gem'                                             , f: false, show_editor: true

    # Models
    # new_archetype :model_name, :basic_class, definition_subfolder: 'ruby-gem', f: true

    # new_blueprint :backlog           , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :usage             , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :readme            , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
