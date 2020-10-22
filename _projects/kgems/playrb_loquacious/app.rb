# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :playrb_loquacious do
  is_run = 1

  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   'Playrb Loquacious is a Ruby playground project for understanding the Loquacious GEM'
    application                   'playrb_loquacious'
    avatar                        'Developer'
    main_story                    'As a Developer, I want to understand what the Loquacious GEM is doing via example, so that I improve my skills with Ruby'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'playrb_loquacious'
    website                       'http://appydave.com/play-with-ruby/loquacious'
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/kgems/playrb_loquacious'
    data_path                     '_/.data'
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
  actions do
    # github_new_repo s.name
    # run_command 'bundle gem --coc --test=rspec --mit playrb_loquacious', command_creates_top_folder: true
    # run_command 'code .'

    # new_blueprint :bootstrap_bin_hook, definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: true
    # new_blueprint :bootstrap_upgrade , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_02_upgrade.rb' , f: true
    # new_blueprint 'stories'            , definition_subfolder: 'ruby-gem'                                             , f: true, show_editor: true
    # new_blueprint 'features'            , definition_subfolder: 'ruby-gem'                                             , f: false, show_editor: true
  end if is_run == 1

end
