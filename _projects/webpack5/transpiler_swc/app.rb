KDsl.microapp :transpiler_swc do
  settings do
    name                          parent.key
    app_type                      'WebpackApp'
    title                         'Transpiler SWC'
    description                   'Transpiler SWC using Webpack 5'
    application                   'TranspilerSwc'
    git_repo_name                 'TranspilerSwc'
    git_organization              'klueless-webpack5-samples'
    avatar                        'SPA Developer'
    main_story                    'As a SPA Developer, I want use the latest EcmaScript features, so that I can have a productive coding experience'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    author_website                'https://appydave.com'
    copyright_date                '2021'
    website                       'http://appydave.com/webpack5/by-example/transpiler-swc'
    application_lib_path          'TranspilerSwc'
    namespace_root                'TranspilerSwc'
    template_rel_path             'html'
    app_path                      '~/dev/webpack5/TranspilerSwc'
    data_path                     '_/.data'
    run_section                   3
  end

  is_run = 0

  def on_action
    s = d.settings

    case s.run_section
    when 0 # Delete the Repo
      github_del_repo s.git_repo_name, organization: s.git_organization
    when 1 # Create the Repo
      github_new_repo s.git_repo_name, organization: s.git_organization
    when 2 # Create package.json
      # setup_package(s)
      rc 'npx npe scripts.build "webpack"'
      rc 'npx npe scripts.start "webpack serve"'
      rc 'npx npe scripts.build:prod "webpack --mode production"'
    when 3 # Setup WebPack V4 for now
      rc 'npm i --save-dev webpack@4 webpack-cli webpack-dev-server'
    when 4 # Add SWC Transpiler
      # rc 'npm i -D @swc/core swc-loader regenerator-runtime'
      rc 'npm i -D @swc/cli @swc/core swc-loader'
      rc 'npx npe scripts.transpile "npx swc src -d dist"'
      rc 'npx npe scripts.run "node dist/index.js"'

    when 5 # Add Babel Transpiler
      rc 'npm i -D @babel/core @babel/cli @babel/preset-env babel-loader'
      rc 'npx npe scripts.transpile "npx babel src --out-dir dist --presets=@babel/env"'
      rc 'npx npe scripts.run "node dist/index.js"'
    
    when 20
      http_resource_to_file(url: 'https://raw.githubusercontent.com/klueless-html-samples/L04TranspilerBabel/master/src/index.js',
                            target_folder: 'src',
                            target_file: 'index.js')

    when 99
      new_blueprint :bootstrap,
                    definition_subfolder: 'webpack5',
                    output_filename: 'bootstrap.rb',
                    f: false,
                    show_editor: true
    end
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

  def setup_package(s)
    rc 'code .' # rc will ensure the folder exists

    rc 'git init .'
    rc 'mkdir src dist'
    
    # Standard NPM configuration
    rc "npm set init.author.name \"#{s.author}\""
    rc "npm set init.author.email \"#{s.author_email}\""
    rc "npm set init.author.url \"#{s.author_website}\""
    rc 'npm set init.license "MIT"'
    rc 'npm init -y'

    # Use NPE to set additional properties
    rc "npx npe name \"#{s.name}\""
    rc "npx npe description \"#{s.description}\""
  end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
