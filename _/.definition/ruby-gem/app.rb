# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  is_run = false

  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   '{{titleize name}} {{settings.description_suffix}}'
    application                   '{{snake name}}'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/{{settings.website_slug_group}}/{{dashify settings.website_slug}}'
    main_story                    '{{settings.main_story}}'
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/{{settings.project_group}}/{{snake name}}'
    data_path                     '_/.data'
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
  actions do
    github_new_repo s.name
    run_command 'bundle gem --coc --test=rspec --mit {{name}}', command_creates_top_folder: true
    run_command 'code .'

    new_blueprint :bootstrap_bin_hooks, definition_subfolder: 'ruby-gem', f: true
  end if is_run == 1

end
