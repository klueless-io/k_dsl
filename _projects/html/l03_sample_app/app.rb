# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :l03_sample_app do
  settings do
    name                          parent.key
    app_type                      'HTML App'
    title                         'L03 Sample App'
    description                   'L03 Sample App in HTML'
    application                   'L03SampleApp'
    git_repo_name                 'L03SampleApp'
    git_organization              'klueless-html-samples'
    avatar                        'UX Designer'
    main_story                    'As a UX Designer, I want to use an off the shelf CSS framework, so that I can style my website components quickly'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/html/samples/l03-sample-app'
    application_lib_path          'L03SampleApp'
    namespace_root                'L03SampleApp'
    template_rel_path             'html'
    app_path                      '~/dev/html/L03SampleApp'
    data_path                     '_/.data'
  end

  is_run = 0

    # Ian from Finite (FinStroke)
    # Ming from XYZ (Abc)

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-html-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-html-samples'

    # If you want the latest html5boilerplater
    # run_command 'npx create-html5-boilerplate .'
    # run_command 'npm install'
    # run_command 'npm-check'
    # run_command 'npm audit fix --force'

    # If you want the latest bootstrap
    run_command 'mkdir src dist config'
    run_command 'git init .'
    run_command 'npm init -y'
    run_command 'npm install webpack webpack-cli --save-dev'
    run_command 'npm install bootstrap@next'
    run_command 'npm install sass-loader sass webpack --save-dev'
    run_command 'npm install --save-dev postcss-loader postcss'
    run_command ''
    run_command ''
    run_command ''


    # run_command 'code .' # run_command will ensure the folder exists

    # new_blueprint :bootstrap       , definition_subfolder: 'html', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
