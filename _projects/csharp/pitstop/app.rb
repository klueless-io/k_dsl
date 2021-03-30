# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :pitstop do
  settings do
    name                          parent.key
    app_type                      'C# Solution'
    description                   'Pitstop Based on ideas from EdwinVW/pitstop, this repo re-imagines the Garage Management System for Pitstop - a fictitious garage / car repair shop.'
    application                   'Pitstop'
    git_repo_name                 'Pitstop'
    git_organization              'klueless-io'
    avatar                        'C# Developer'
    main_story                    'As a C# Developer, I want a simple MVC application, so that I practice web apps'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/csharp/samples/pitstop'
    application_lib_path          'Pitstop'
    namespace_root                'Pitstop'
    template_rel_path             'csharp-mvc'
    app_path                      '~/dev/csharp/Pitstop'
    data_path                     '_/.data'
  end

  is_run = 1

  # run.rake: project_cs_pitstop = build_project('c#/pitstop')

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name
    # github_new_repo s.git_repo_name
    # run_command 'dotnet new mvc -n Pitstop -o .'
    # run_command 'dotnet new gitignore -o .'
    # run_command 'code .'

    # Add support for MS Sql and Postgres via EF4
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.SqlServer'
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.Design'
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.Tools'
    # run_command 'dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL'
    # run_command 'dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL.Design'
    # run_command 'dotnet add package StyleCop.Analyzers'
    # run_command 'dotnet add package Microsoft.CodeAnalysis.FxCopAnalyzers'

    # dotnet user-secrets init
    # dotnet user-secrets set "Db:Password" "12345"
    # <PropertyGroup>
    #   <CodeAnalysisRuleSet>StyleCop.ruleset</CodeAnalysisRuleSet>
    # </PropertyGroup>

    # run_command 'dotnet add package Microsoft.Extensions.Configuration'
    # run_command 'dotnet add package Microsoft.Extensions.Configuration.Json'
    # run_command 'dotnet add package Microsoft.Extensions.Configuration.Binder'
    # run_command 'dotnet add package Microsoft.Extensions.Configuration.CommandLine'
    # run_command 'dotnet add package Microsoft.Extensions.Configuration.EnvironmentVariables'
    # run_command 'dotnet add package Microsoft.Extensions.DependencyInjection'
    # run_command 'dotnet add package Microsoft.Extensions.Hosting'
    
    # new_blueprint :bootstrap_bin_hook       , definition_subfolder: 'csharp-console', output_filename: 'bootstrap_01_bin_hook.rb', f: false, show_editor: true
    # new_blueprint :basic_class              , definition_subfolder: 'csharp-console'                                             , f: false, show_editor: true

    # Models
    # new_archetype :model_name, :basic_class, definition_subfolder: 'csharp-console', f: true

    # new_blueprint :backlog           , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :usage             , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :readme            , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
