# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :handlebars_helpers do
  settings do
    ruby_version                  '2.7.2'

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   'Handlebars Helpers is a library that provides (x) handlebars helpers across (y) categories, it was built to complement [cowboyd/handlebars.rb](https://github.com/cowboyd/handlebars.rb) with Ruby helpers commonly found in the Javascript community'
    application                   'handlebars-helpers'
    avatar                        'Developer'
    main_story                    'As a Ruby Developer, I want to use HandlebarsJS with useful helpers, so that I have a rich templating experience'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2020'
    website                       'http://appydave.com/gems/handlebars-helpers'
    application_lib_path          'handlebars/helpers'
    application_lib_namespace     'Handlebars::Helpers'
    application_lib_namespaces    ['Handlebars', 'Helpers']
    template_rel_path             'ruby-gem'
    app_path                      '~/dev/kgems/handlebars-helpers'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_new_repo s.application
    # run_command 'bundle gem --coc --test=rspec --mit handlebars-helpers', command_creates_top_folder: true
    # run_command 'code .'

    # cd /Users/davidcruwys/dev/kgems/rspec-usecases
    # mkdir _
    # cd _

    # ln -s /Users/davidcruwys/dev/kgems/k_dsl/_projects/kgems/rspec-usecases ./app
    # ln -s /Users/davidcruwys/dev/kgems/k_dsl/_projects/kgems/handlebars-helpers ./app

    # ln -s /Users/davidcruwys/dev/kgems/k_dsl/_/.definition/ruby-gem ./def-ruby-gem
    # ln -s /Users/davidcruwys/dev/kgems/k_dsl/_/.template/ruby-gem ./tem-ruby-gem

    # new_blueprint :bootstrap_bin_hook, definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_01_bin_hook.rb', f: false, show_editor: true
    # new_blueprint :bootstrap_upgrade , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_02_upgrade.rb' , f: false, show_editor: true
    # new_blueprint :bootstrap_github_actions , definition_subfolder: 'ruby-gem', output_filename: 'bootstrap_03_github_actions.rb' , f: false, show_editor: true
    # new_blueprint :basic_class       , definition_subfolder: 'ruby-gem'                                             , f: false, show_editor: true

    # Models
    # new_archetype :model_name, :basic_class, definition_subfolder: 'ruby-gem', f: true

    # Requirements
    # new_blueprint :backlog           , definition_subfolders: ['ruby-gem', 'requirements'], output_subfolder: 'requirements', show_editor: true
    # new_blueprint :stories           , definition_subfolders: ['ruby-gem', 'requirements'], output_subfolder: 'requirements', show_editor: true
    # new_blueprint :usage             , definition_subfolders: ['ruby-gem', 'requirements'], output_subfolder: 'requirements', show_editor: true, f: true
    # new_blueprint :readme            , definition_subfolders: ['ruby-gem', 'requirements'], output_subfolder: 'requirements', show_editor: true, f: true

  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
