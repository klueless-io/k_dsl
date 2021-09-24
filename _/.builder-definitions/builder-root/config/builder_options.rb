log.kv 'load', 'builder_options' if AppDebug.require?

class BuilderOptions
  extend BuilderOptionsClassHelper

  def initialize
    debug(0)
    create_project(0)
  end

  # Turn on debugging for the following artifacts
  # BuilderOptions.generate_options_method(builder, :debug, params: %i[], flags: %i[me builder_config app_settings])
  def debug(active, me: 0, builder_config: 0, app_settings: 0)
    active = active == true || active == 1

    # Flags
    me = active && (me == true || me == 1)
    builder_config = active && (builder_config == true || builder_config == 1)
    app_settings = active && (app_settings == true || app_settings == 1)

    @debug = {
      active: active,
      me: me,
      builder_config: builder_config,
      app_settings: app_settings
    }

    self
  end

  # BuilderOptions.generate_options_method(builder, :create_project, flags: %i[create delete bootstrap force], params: %i[filter_project_name])
  def create_project(active, create: 0, delete: 0, bootstrap: 0, force: 0, filter_project_name: '')
    active = active == true || active == 1

    # Flags
    create = active && (create == true || create == 1)
    delete = active && (delete == true || delete == 1)
    bootstrap = active && (bootstrap == true || bootstrap == 1)
    force = active && (force == true || force == 1)

    @create_project = {
      active: active,
      create: create,
      delete: delete,
      bootstrap: bootstrap,
      force: force,
      filter_project_name: filter_project_name
    }

    self
  end
  
  def build
    data = {
      debug: @debug,
      create_project: @create_project,
    }
    KUtil.data.to_open_struct(data)
  end

  def print
    log.section_heading 'debug options'
    log.open_struct(build)
  end
end

