# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :k_builder_package_json do
  settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   'KBuilder-PackageJson provides various fluent builders and code generators for building package.json file'
    application                   'k_builder-package_json'
    avatar                        'Developer'
    main_story                    'As a Javascript Developer, I want to automatically configure package.json with my defaults, so I can get up and running quickly'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/gems/k-builder-package-json'
    application_lib_path          'k_builder/package_json'
    application_lib_namespace     'KBuilder::PackageJson'
    application_lib_namespaces    ['KBuilder', 'PackageJson']
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/kgems/k_builder-package_json'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_new_repo s.application
    # run_command 'bundle gem --coc --test=rspec --mit k_builder-package_json', command_creates_top_folder: true
    # run_command 'code .'

    # new_blueprint :bootstrap_bin_hook       , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: false, show_editor: true
    # new_blueprint :bootstrap_upgrade        , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_02_upgrade.rb' , f: false, show_editor: true
    # new_blueprint :bootstrap_github_actions , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_03_github_actions.rb' , f: false, show_editor: true
    # new_blueprint :basic_class              , definition_subfolder: 'ruby-gem'                                             , f: false, show_editor: true

    # Models
    # new_archetype :model_name, :basic_class, definition_subfolder: 'ruby-gem', f: true

    # new_blueprint :backlog           , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :usage             , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :readme            , definition_subfolder: 'ruby-gem/requirements', output_subfolder: 'requirements', show_editor: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
