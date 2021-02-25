# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :l02_bootstrap_getting_started do
  settings do
    name                          parent.key
    app_type                      'HTML App'
    title                         'L02 Bootstrap Getting Started'
    description                   'L02 Bootstrap Getting Started in HTML'
    application                   'L02BootstrapGettingStarted'
    git_repo_name                 'L02BootstrapGettingStarted'
    git_organization              'klueless-html-samples'
    avatar                        'UX Designer'
    main_story                    'As a UX Designer, I want to use an off the shelf CSS framework, so that I can style my website components quickly'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/html/samples/l02-bootstrap-getting-started'
    application_lib_path          'L02BootstrapGettingStarted'
    namespace_root                'L02BootstrapGettingStarted'
    template_rel_path             'html'
    app_path                      '~/dev/html/L02BootstrapGettingStarted'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-html-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-html-samples'
    run_command 'code .' # run_command will ensure the folder exists

    # new_blueprint :bootstrap       , definition_subfolder: 'html', output_filename: 'bootstrap.rb', f: false, show_editor: true

    run_command 'npm install bootstrap@next'
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
