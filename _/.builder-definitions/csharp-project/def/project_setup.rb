class ProjectSetup
  attr_accessor :builder
  attr_accessor :solution
  attr_accessor :project
  
  attr_accessor :project_flag
  attr_accessor :project_setup

  def initialize(builder, solution_settings, project_settings, opts)
    @builder              = builder
    @solution             = KUtil.data.to_open_struct(solution_settings)
    @project              = KUtil.data.to_open_struct(project_settings)
    @project_flag         = opts.project_flag
    @project_setup        = opts.project_setup
  end

  def execute
    builder.cd(:project)

    add_entity_framework  if project_setup.add_entity_framework
    add_sql_server        if project_setup.add_sql_server
    add_pgsql             if project_setup.add_pgsql
    add_serilog           if project_setup.add_serilog
    initialize_secret     if project_setup.initialize_secret
    cop                   if project_setup.cop

  end

  private

  # ----------------------------------------------------------------------
  # Add new packages
  # ----------------------------------------------------------------------

  def add_entity_framework
    builder.run_command('dotnet add package Microsoft.EntityFrameworkCore.Design')
    builder.run_command('dotnet add package Microsoft.EntityFrameworkCore.Tools')
  end

  def add_sql_server
    add_entity_framework

    if project_flag.use_sql_server
      builder.run_command('dotnet add package Microsoft.EntityFrameworkCore.SqlServer')
    else
      log.error('Cannot add SQL Server package while project_flag.use_sql_server is false')
    end
  end

  def add_pgsql
    add_entity_framework

    if project_flag.use_pgsql
      builder.run_command('dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL')
      builder.run_command('dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL.Design')
    else
      log.error('Cannot add PostgreSQL package while project_flag.use_pgsql is false')
    end
  end

  def add_serilog
    builder.run_command('dotnet add package Serilog')
    builder.run_command('dotnet add package Serilog.Sinks.Console')
    builder.run_command('dotnet add package Serilog.Sinks.Console')
    builder.run_command('dotnet add package Serilog.Enrichers.Environment')
    # builder.run_command('dotnet add package Serilog.Sinks.File')
  end

  def initialize_secret
    builder.run_command('dotnet user-secrets init')
    # dotnet user-secrets set "Db:Password" "12345"
  end

  def cop
    #  Manually add this to project, todo: Support XML file updates so this can be automated
    #  <CodeAnalysisRuleSet>StyleCop.ruleset</CodeAnalysisRuleSet>
    builder
      .add_file('StyleCop.ruleset', template_file: 'StyleCop.ruleset')
      .run_command('dotnet add package StyleCop.Analyzers')

    # Going to need to use NokiGori to do this
    # <CodeAnalysisRuleSet>StyleCop.ruleset</CodeAnalysisRuleSet>
    # csproj = File.expand_path(File.join(project.app_path, "#{project.application}.csproj"))
    # if File.exist?(csproj)
    #   content = File.read(csproj)
    # end
  end

end