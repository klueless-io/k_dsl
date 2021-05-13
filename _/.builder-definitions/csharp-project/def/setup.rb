require 'k_log'
require 'k_util'
require 'config/_'

require_relative '../../.builders/config/app_settings'
require_relative '../../.data/project_list'
require_relative '../../.data/entity_methods'
require_relative '../../.data/entities_all'

require 'config/builder_config'
require 'config/builder_options'
require 'config/project_setup'
require 'config/project_code'
require 'config/ef_migration'

option_builder = BuilderOptions
                  .init
                  .debug(1, me: 0, config: 0, app: 0, entities: 0)
                  .project_flag(1,
                    use_sql_server: 0,
                    use_pgsql: 0)
                  .project_setup(1,
                    add_entity_framework: 0,
                    add_sql_server: 0,
                    add_pgsql: 0,
                    add_serilog: 0,
                    initialize_secret: 0,
                    cop: 0)
                  .project_code(1,
                    add_starter_code: 0,
                    add_documents: 0,
                    add_ef_entities: 0,
                    add_ef_context: 0,
                    add_entity_admin: 0) # This only makes sense on web apps
                  .ef_migrations(1,
                    add_migration: 0, migration_name: 'Initial',
                    run_migration: 0)
  
opts = option_builder.build
# Display settings by turning on specific debug flags

option_builder.print                    if opts.debug.me
AppSettings.debug                       if opts.debug.app
KBuilder.configuration.debug            if opts.debug.config

solution_settings = AppSettings.current.solution
project_settings = AppSettings.current.project(:{{project.name}})

get_entities = EntitiesAll.new
get_entities.debug                          if opts.debug.entities
entities = get_entities.entities

if opts.project_setup.active
  project_setup = ProjectSetup.new(builder, solution_settings, project_settings, opts)
  project_setup.execute
end

if opts.project_code.active
  project_code = ProjectCode.new(builder, solution_settings, project_settings, entities, opts)
  project_code.execute
end

if opts.ef_migrations.active
  ef_migrations = EfMigration.new(builder, solution_settings, project_settings, opts)
  ef_migrations.execute
end

puts 'DONE!'