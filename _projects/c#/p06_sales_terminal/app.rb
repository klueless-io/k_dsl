# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :p06_sales_terminal do
  settings do
    name                          parent.key
    app_type                      'C# Console app'
    description                   'P06 Sales Terminal domain model for a shop with cash registers'
    application                   'P06SalesTerminal'
    git_repo_name                 'P06SalesTerminal'
    git_organization              'klueless-csharp-samples'
    avatar                        'C# Developer'
    main_story                    'As a C# Developer, I want to model a shot with cash registers, so that I practice domain modeling'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/csharp/samples/p06-sales-terminal'
    application_lib_path          'P06SalesTerminal'
    namespace_root                'P06SalesTerminal'
    template_rel_path             'csharp-console'
    app_path                      '~/dev/c#/P06SalesTerminal'
    data_path                     '_/.data'
  end

  is_run = 1

  # run.rake: project_cs_p06_sales_terminal = build_project('c#/p06_sales_terminal')

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-csharp-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-csharp-samples'
    # run_command 'dotnet new console -n P06SalesTerminal -o .'
    # run_command 'dotnet new gitignore -o .'
    # run_command 'code .'

    # Add support for MS Sql and Postgres via EF4
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.SqlServer'
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.Design'
    # run_command 'dotnet add package Microsoft.EntityFrameworkCore.Tools'
    # run_command 'dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL'
    # run_command 'dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL.Design'
    # run_command 'dotnet add package StyleCop.Analyzers'

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
    # new_archetype :store, :basic_class, definition_subfolder: 'csharp-console', f: true
    # new_archetype :terminal, :basic_class, definition_subfolder: 'csharp-console', f: true
    # new_archetype :sale, :basic_class, definition_subfolder: 'csharp-console', f: true
    # new_archetype :sale_line_item, :basic_class, definition_subfolder: 'csharp-console', f: true
    # new_archetype :product, :basic_class, definition_subfolder: 'csharp-console', f: true

    # new_blueprint :backlog           , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :usage             , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :readme            , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
