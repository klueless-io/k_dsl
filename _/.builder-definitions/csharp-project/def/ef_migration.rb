class EfMigration
  attr_accessor :builder
  attr_accessor :solution
  attr_accessor :project
  
  attr_accessor :project_flag
  attr_accessor :ef_migrations

  def initialize(builder, solution_settings, project_settings, opts)
    @builder              = builder
    @solution             = KUtil.data.to_open_struct(solution_settings)
    @project              = KUtil.data.to_open_struct(project_settings)
    @project_flag         = opts.project_flag
    @ef_migrations        = opts.ef_migrations
  end

  def execute
    builder.cd(:project)

    add_migration         if ef_migrations.add_migration
    run_migration         if ef_migrations.run_migration
  end

  private

  # ----------------------------------------------------------------------
  # Add EF migration helpers
  # ----------------------------------------------------------------------

  # ef migrations remove to remove previous migration
  def add_migration
    guard_sql_or_pg_required

    builder.rc("dotnet ef migrations add #{ef_migrations.migration_name} --context MsDbContext") if project_flag.use_sql_server
    builder.rc("dotnet ef migrations add #{ef_migrations.migration_name} --context PgDbContext") if project_flag.use_pgsql
  end
  
  def run_migration
    guard_sql_or_pg_required

    builder.rc('dotnet ef database update --context MsDbContext') if project_flag.use_sql_server
    builder.rc('dotnet ef database update --context PgDbContext') if project_flag.use_pgsql
  end

  def guard_sql_or_pg_required
    return true if project_flag.use_sql_server || project_flag.use_pgsql

    log.error('SQL server or Postgres is require for this action')

    return false
  end
end