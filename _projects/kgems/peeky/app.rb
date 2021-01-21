# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :peeky do
  is_run = 1

  settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   'Peeky is a Ruby GEM for peaking into ruby classes and extracting meta'
    application                   'peeky'
    avatar                        'Developer'
    main_story                    'As a Ruby Developer, I should be able to Reverse engineer classes and methods, so that I can document and understand them'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'peeky'
    website                       'http://appydave.com/gems/peeky'
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/kgems/peeky'
    data_path                     '_/.data'
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
  def on_action
    s = d.settings
    # github_new_repo s.name
    # run_command 'bundle gem --coc --test=rspec --mit peeky', command_creates_top_folder: true
    # run_command 'code .'

    # new_archetype :api, :basic_class, definition_subfolder: 'ruby-gem', f: true

    # new_archetype :attr_info, :basic_class, definition_subfolder: 'ruby-gem', f: true
    # new_archetype :class_info, :basic_class, definition_subfolder: 'ruby-gem', f: true
    # new_archetype :parameter_info, :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :method_info, :basic_class, definition_subfolder: 'ruby-gem', f: true

    # new_archetype :attr_reader_predicate, :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :attr_writer_predicate, :basic_class, definition_subfolder: 'ruby-gem'

    # new_archetype :class_debug_render                 , :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :class_interface_yard_render        , :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :class_interface_render             , :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :method_call_minimum_params_render  , :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :method_signature_render            , :basic_class, definition_subfolder: 'ruby-gem'
    # new_archetype :method_signature_with_debug_render , :basic_class, definition_subfolder: 'ruby-gem'

    # new_blueprint :bootstrap_bin_hook, definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: true, show_editor: true
    # new_blueprint :bootstrap_bin_hook, definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: true, show_editor: true
    # new_blueprint :bootstrap_upgrade , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_02_upgrade.rb' , f: true, show_editor: true
    # new_blueprint :basic_class       , definition_subfolder: 'ruby-gem'                                             , f: true, show_editor: true

    # new_blueprint :stories  , definition_subfolder: 'ruby-gem', output_subfolder: 'requirements', show_editor: true
    # new_blueprint :features , definition_subfolder: 'ruby-gem', output_subfolder: 'requirements', show_editor: true

    # new_archetype :generate_yard_documentation, :basic_class, definition_subfolder: 'ruby-gem', show_editor: true
  end if is_run == 1

end
