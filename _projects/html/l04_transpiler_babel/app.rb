# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :l04_transpiler_babel do
  settings do
    name                          parent.key
    app_type                      'HTML App'
    title                         'L04 Transpiler Babel'
    description                   'L04 Transpiler Babel in HTML'
    application                   'L04TranspilerBabel'
    git_repo_name                 'L04TranspilerBabel'
    git_organization              'klueless-html-samples'
    avatar                        'UX Designer'
    main_story                    'As a Javascript Developer, I want to target the latest ES features while maintaining browser compatibility, so that I can code fast but support older browsers'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/html/samples/l04-transpiler-babel'
    application_lib_path          'L04TranspilerBabel'
    namespace_root                'L04TranspilerBabel'
    template_rel_path             'html'
    app_path                      '~/dev/html/L04TranspilerBabel'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-html-samples'
    github_new_repo s.git_repo_name, organization: 'klueless-html-samples'

    run_command 'code .' # run_command will ensure the folder exists

    #### run_command 'git init .'
    # run_command 'mkdir src dist'
    # run_command 'npm init -y'

    # Setup WebPack V4 for now
    # run_command 'npm install --save webpack@4 webpack-cli webpack-dev-server'
    # run_command 'npm install --save css-loader style-loader'                    # embed css to javascript
    # run_command 'npm install --save html-loader@1'                              # embed html to javascript, note: WebPack4 does not support html-loader2
    # run_command 'npm install --save extract-loader'                             # extract the resource as raw string
    # run_command 'npm install --save file-loader'                                # The file-loader resolves import/require() on a file into a url and emits the file into the output directory.

    # UNKNOWN, revisit
    # run_command 'npm install sass-loader sass webpack --save'

    # Setup Transpilers for ES6 support
    # run_command 'npm install --save-dev @babel/core @babel/cli @babel/preset-env' # Babel
    # run_command 'npm install --save @babel/polyfill'

    # run_command 'npm install bootstrap@next'
    # run_command 'mkdir src dist config'
    # run_command ''
    # run_command ''
    # run_command ''

    # If you want the latest html5boilerplater
    # run_command "npx create-html5-boilerplate #{s.application}"
    # If you want the latest bootstrap
    # run_command 'npm install bootstrap@next'


    new_blueprint :bootstrap       , definition_subfolder: 'html', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
