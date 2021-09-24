log.info 'builder_options' if AppDebug.require?

class BuilderOptions
  extend BuilderOptionsClassHelper

  def initialize
    puts 'instance of builder options'
    # debug(0)
    # create_project(0)
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

  # Example for building a section
  #   BuilderOptions.generate_options_method(builder, :create_projects, params: %i[name], flags: %i[create delete])

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

