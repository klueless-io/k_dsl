log.warn 'config' if AppDebug.require?

require_relative './app_settings'
require_relative './configure_builder'
require_relative './builder_options'
