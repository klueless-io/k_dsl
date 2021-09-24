log.kv 'load', 'configure_builder' if AppDebug.require?

def builder
  @builder ||= KBuilder::BaseBuilder.init
end

KBuilder.configure do |config|
  raise 'app.settings.app_path is required' if app.settings.app_path.nil?

  base_folder       = app.settings.app_path
  templates_root    = '~/dev/kgems/k_dsl/_/.template'
  definition_root   = '~/dev/kgems/k_dsl/_/.builder-definitions'
  
  # Target folders
  config.target_folders.add(:root           , base_folder)
  config.target_folders.add(:root_builder   , :root, '.builders')

  # # Builder Definitions
  config.template_folders.add(:definitions  , definition_root, 'builder-common')

  # base_template_folder = File.expand_path(File.join(base_folder, '.builder_templates'))
  # base_local_folder = File.expand_path(File.join(Dir.getwd, '../_local'))
  
  # base_documentation_repo = '~/dev/printspeak/documentation'

  # config.target_folders.add(:local          , base_local_folder)
  # config.target_folders.add(:club           , :local, 'club_membership')
  # config.target_folders.add(:samples        , base_local_folder)
  # config.target_folders.add(:documentation  , base_documentation_repo, '_')
  # config.target_folders.add(:poc            , base_documentation_repo, '_Printspeak')
  # config.target_folders.add(:poc_x          , base_documentation_repo, '_Printspeakx')

  # # config.template_folders.add(:global       , base_template_folder)
  # config.template_folders.add(:erd          , root_templates, 'erd')
  # config.template_folders.add(:r6_setup     , root_templates, 'rails6-1-app-setup')
  # config.template_folders.add(:r6_core      , root_templates, 'rails6-2-app-core')
  # config.template_folders.add(:r6_domain    , root_templates, 'rails6-3-domain-v1')
end


# KBuilder.configure do |config|
#   solution_root       = '~/dev/csharp/P15Areas'
#   project_root       = '~/dev/csharp/P15Areas'
#   templates_root    = '~/dev/kgems/k_dsl/_/.template'

#   config.target_folders.add(:root         , solution_root)
#   config.target_folders.add(:data         , solution_root, '.data')
#   config.target_folders.add(:project      , project_root)

#   # NOTE: The templates should really be related to the project type and variant,
#   # e.g. there is no need for csharp-ef for anything but an entity framework project
#   # General C#
#   config.template_folders.add(:csharp     , File.join(templates_root, 'csharp'))

#   # Entity framework
#   config.template_folders.add(:csharp_ef  , File.join(templates_root, 'csharp-ef'))

#   # Entity web application
#   config.template_folders.add(:csharp_web , File.join(templates_root, 'csharp-web'))
# end
