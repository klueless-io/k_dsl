# ------------------------------------------------------------
# MicroApp: Ruby Commandlet
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  is_run = 0

  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Commandlet'
    description                   '{{titleize name}} is a command line tool for '
    application                   '{{dashify name}}'
    avatar                        'Developer'
    main_story                    '{{settings.main_story}}'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/{{settings.website_slug}}/{{dashify name}}'
    template_rel_path             'ruby-cmdlet'
    app_path                      '~/dev/cmdlets/{{dashify name}}'
    data_path                     '_/.data'
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
  def on_action
    # github_delete_repo s.name
    github_new_repo s.name
    run_command 'bundle gem --coc --test=rspec --mit {{name}}', command_creates_top_folder: true
    run_command 'code .'

    new_blueprint :bootstrap_01_bin_hook    , definition_subfolder: 'ruby-gem'    , f: true
    new_blueprint :bootstrap_cmdlet         , definition_subfolder: 'ruby-cmdlet' , f: true
    
    # ToDo: Definition and Template folders should come from specific settings areas within the microap
    # new_structure 'stories'   , definition_subfolder: 'ruby-cmdlet', f: false, show_editor: true

    # new_structure 'commands', definition_name: 'ruby-cmdlet_commands', f: true

    # new_archetype :config, :command, definition_name: 'ruby-cmdlet_command_main', f: true
    # new_archetype :basic_command, :command, definition_name: 'ruby-cmdlet_command', f: true
    # new_archetype :main_menu_command, :command, definition_name: 'ruby-cmdlet_command_main', f: true

    # new_entity :command, definition_name: 'cmdlet_command_list', description: 'represents the commands that will be available for this cmdlet', f: true
  end if is_run == 1

end
