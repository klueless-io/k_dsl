# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :p04_domain_monopoly_v1 do
  settings do
    name                          parent.key
    app_type                      'C# Console app'
    description                   'P04 Domain Monopoly V1 domain model for the monopoly game V1'
    application                   'P04DomainMonopolyV1'
    git_repo_name                 'P04DomainMonopolyV1'
    git_organization              'klueless-csharp-samples'
    avatar                        'C# Developer'
    main_story                    'As a C# Developer, I want to model a simple Monopoly game, so that I practice domain modeling'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/csharp/samples/p04-domain-monopoly-v1'
    application_lib_path          'P04DomainMonopolyV1'
    namespace_root                'P04DomainMonopolyV1'
    template_rel_path             'csharp-console'
    app_path                      '~/dev/c#/P04DomainMonopolyV1'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-csharp-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-csharp-samples'
    # run_command 'dotnet new console -n P04DomainMonopolyV1 -o .'
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
    # new_blueprint :bootstrap_upgrade        , definition_subfolder: 'csharp-console', output_filename: 'bootstrap_02_upgrade.rb' , f: false, show_editor: true
    # new_blueprint :bootstrap_github_actions , definition_subfolder: 'csharp-console', output_filename: 'bootstrap_03_github_actions.rb' , f: false, show_editor: true
    # new_blueprint :basic_class              , definition_subfolder: 'csharp-console'                                             , f: false, show_editor: true

    # Models
    # https://www.mtholyoke.edu/~blerner/cs315/Monopoly/MonopolyRules.pdf
    # new_archetype :board, :model, definition_subfolder: 'csharp-console', f: true

    # new_archetype :game           , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :player         , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :property       , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :event_card     , :model, definition_subfolder: 'csharp-console', f: true
    new_archetype :board         , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :square         , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :square_land    , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :square_railroad, :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :square_utility , :model, definition_subfolder: 'csharp-console', f: true
    # new_archetype :square_special , :model, definition_subfolder: 'csharp-console', f: true


    # new_archetype :bank           , :model, definition_subfolder: 'csharp-console', f: true
    # Go, Chance, Community, Parking
    
    # Each player is given $1500 divided as follows: 
    # 2 x $500 
    # 2 x $100
    # 2 x $50
    # 6 x $20
    # 5 x $10
    # 5 x $5
    # 5 x $1

    # new_blueprint :backlog           , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :usage             , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :readme            , definition_subfolder: 'csharp-console/requirements', output_subfolder: 'requirements', show_editor: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
