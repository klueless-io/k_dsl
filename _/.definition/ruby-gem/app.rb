# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   '{{titleize name}} {{settings.description_suffix}}'
    application                   '{{dashify name}}'
    avatar                        'Developer'
    main_story                    '{{settings.main_story}}'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2020'
    website                       'http://appydave.com/{{settings.website_slug_group}}/{{dashify settings.website_slug}}'
    application_lib_path          '{{slash name}}'
    application_lib_namespace     '{{format_as name "titleize,namespace"}}'
    application_lib_namespaces    [{{custom_namespace_array name}}]
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/{{settings.project_group}}/{{dashify name}}'
    data_path                     '_/.data'
  end

  is_run = 0

  def on_action
    s = d.settings
    github_new_repo s.application
    run_command 'bundle gem --coc --test=rspec --mit {{name}}', command_creates_top_folder: true
    run_command 'code .'

    # new_blueprint :bootstrap_bin_hook, definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: false, show_editor: true
    # new_blueprint :bootstrap_upgrade , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_02_upgrade.rb' , f: false, show_editor: true
    # new_blueprint :basic_class       , definition_subfolder: 'ruby-gem'                                             , f: false, show_editor: true

    # Models
    # new_archetype :model_name, :basic_class, definition_subfolder: 'ruby-gem', f: true

    # new_blueprint :backlog           , definition_subfolder: 'ruby-gem', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolder: 'ruby-gem', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :features          , definition_subfolder: 'ruby-gem', output_subfolder: 'requirements', show_editor: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
