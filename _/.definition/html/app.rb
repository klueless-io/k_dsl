# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  settings do
    name                          parent.key
    app_type                      'HTML App'
    title                         '{{titleize name}}'
    description                   '{{titleize name}} {{settings.description_suffix}}'
    application                   '{{camel name}}'
    git_repo_name                 '{{camel name}}'
    git_organization              'klueless-html-samples'
    avatar                        'UX Designer'
    main_story                    '{{settings.main_story}}'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/{{settings.website_slug_group}}/{{dashify settings.website_slug}}'
    application_lib_path          '{{camel name}}'
    namespace_root                '{{camel name}}'
    template_rel_path             'html'
    app_path                      '~/dev/{{settings.project_group}}/{{camel name}}'
    data_path                     '_/.data'
  end

  is_run = 1

  # run.rake: project_html_{{snake name}} = build_project('html/{{snake name}}')
  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-html-samples'
    github_new_repo s.git_repo_name, organization: 'klueless-html-samples'

    run_command 'code .' # run_command will ensure the folder exists

    #### run_command 'git init .'
    run_command 'mkdir src dist config'
    run_command 'npm init -y'

    # Setup WebPack V4 for now
    # run_command 'npm i --save-dev webpack@4 webpack-cli webpack-dev-server'
    # run_command 'npm i --save-dev css-loader style-loader'                    # embed css to javascript
    # run_command 'npm i --save-dev html-loader@1'                              # embed html to javascript, note: WebPack4 does not support html-loader2
    # run_command 'npm i --save-dev extract-loader'                             # extract the resource as raw string
    # run_command 'npm i --save-dev file-loader'                                # The file-loader resolves import/require() on a file into a url and emits the file into the output directory.
    # run_command 'npm i --save-dev sass-loader sass'                           # Transpile scss to css

    # WebPack version 4
    # run_command 'npm i --save-dev sass-loader@10.0.0 sass'                    # Transpile scss to css
    # run_command 'npm i --save-dev postcss-loader postcss'                     # Add CSS prefixes

    # Setup Transpilers for ES6 support
    # run_command 'npm i --save-dev @babel/core @babel/cli @babel/preset-env' # Babel
    # run_command 'npm i --save @babel/polyfill'

    # run_command 'npm i --save-dev @swc/core swc-loader'

    # run_command 'npm i bootstrap@next'
    # run_command 'mkdir src dist config'
    # run_command ''
    # run_command ''
    # run_command ''

    # If you want the latest html5boilerplater
    # run_command "npx create-html5-boilerplate #{s.application}"
    # If you want the latest bootstrap
    # run_command 'npm i bootstrap@next'


    # new_blueprint :bootstrap       , definition_subfolder: 'html', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
