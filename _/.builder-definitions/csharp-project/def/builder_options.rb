class BuilderOptions
  class << self
    def init
      BuilderOptions.new
    end
  end

  def initialize
    debug(0)
    project_flag(0)
    project_setup(0)
    project_code(0)
    ef_migrations(0)
  end

  # Turn on debugging for the following artifacts
  def debug(active, me: 0, config: 0, app: 0, entities: 0, opinions: 0)
    active        = active == true || active == 1
    me            = active && (me == true || me == 1)
    config        = active && (config == true || config == 1)
    app           = active && (app == true || app == 1)
    entities      = active && (entities == true || entities == 1)
    opinions      = active && (opinions == true || opinions == 1)

    @debug = {
      active:            active,
      me:                me,
      app:               app,
      entities:          entities,
      config:            config,
      opinions:          opinions
    }

    self
  end

  def project_flag(
    active,
    use_sql_server: 0,
    use_pgsql: 0)

    active                = active == true || active == 1

    use_sql_server        = active && (use_sql_server == true || use_sql_server == 1)
    use_pgsql             = active && (use_pgsql == true || use_pgsql == 1)
    
    @project_flag = {
      active:               active,
      use_sql_server:       use_sql_server,
      use_pgsql:            use_pgsql
    }

    self
  end

  def project_setup(
    active,
    add_entity_framework: 0,
    add_sql_server: 0,
    add_pgsql: 0,
    add_serilog: 0,
    initialize_secret: 0,
    cop: 0)

    active                = active == true || active == 1

    add_entity_framework  = active && (add_entity_framework == true || add_entity_framework == 1)
    add_sql_server        = active && (add_sql_server == true || add_sql_server == 1)
    add_pgsql             = active && (add_pgsql == true || add_pgsql == 1)
    add_serilog           = active && (add_serilog == true || add_serilog == 1)
    initialize_secret     = active && (initialize_secret == true || initialize_secret == 1)
    cop                   = active && (cop == true || cop == 1)
    
    @project_setup = {
      active:               active,
      add_entity_framework: add_entity_framework,
      add_sql_server:       add_sql_server,
      add_pgsql:            add_pgsql,
      add_serilog:          add_serilog,
      initialize_secret:    initialize_secret,
      cop:                  cop
    }

    self
  end

  def project_code(
    active,
    add_starter_code: 0,
    add_documents: 0,
    add_ef_entities: 0,
    add_ef_context: 0,
    add_entity_admin: 0)

    active                = active == true || active == 1

    add_starter_code      = active && (add_starter_code == true || add_starter_code == 1)
    add_documents         = active && (add_documents == true || add_documents == 1)
    add_ef_entities       = active && (add_ef_entities == true || add_ef_entities == 1)       
    add_ef_context        = active && (add_ef_context == true || add_ef_context == 1)
    add_entity_admin      = active && (add_entity_admin == true || add_entity_admin == 1)
    
    @project_code = {
      active:               active,
      add_starter_code:     add_starter_code,
      add_documents:        add_documents,
      add_ef_entities:      add_ef_entities,
      add_ef_context:       add_ef_context,
      add_entity_admin:     add_entity_admin
  }

    self
  end

  def ef_migrations(
    active,
    add_migration: 0,
    migration_name: '',
    run_migration: 0)

    active                = active == true || active == 1

    add_migration         = active && (add_migration == true || add_migration == 1)
    run_migration         = active && (run_migration == true || run_migration == 1)       
    
    @ef_migrations = {
      active:             active,
      add_migration:      add_migration,
      migration_name:     migration_name,
      run_migration:      run_migration
    }

    self
  end

  def build
    data = {
      debug: @debug,
      project_flag: @project_flag,
      project_setup: @project_setup,
      project_code: @project_code,
      ef_migrations: @ef_migrations
    }
    KUtil.data.to_open_struct(data)
  end

  def print
    log.open_struct(build)
  end
end

