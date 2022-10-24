log.kv 'load', 'handlebars_helpers' if AppDebug.require?

KConfig.configure do |config|
  config.handlebars.defaults.add_all_defaults
end
