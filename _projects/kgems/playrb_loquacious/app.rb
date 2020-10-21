# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :playrb_loquacious do
  is_run = 0

  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   'Playrb Loquacious is a Ruby playground project for understanding the Loquacious GEM'
    application                   'playrb_loquacious'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'playrb_loquacious'
    website                       'http://appydave.com/play-with-ruby/loquacious'
    main_story                    'As a Developer, I want to understand what the Loquacious GEM is doing via example, so that I improve my skills with Ruby'
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/kgems/playrb_loquacious'
    data_path                     '_/.data'
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
  actions do
    # github_delete_repo s.name
    # github_new_repo s.name
    # run_command 'bundle gem --coc --test=rspec --mit playrb_loquacious', command_creates_top_folder: true

    new_blueprint :bootstrap_bin_hooks, definition_subfolder: 'ruby-gem', f: true
  end if is_run == 1

end
