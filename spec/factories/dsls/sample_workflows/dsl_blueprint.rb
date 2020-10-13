KDsl.blueprint :spidy_expireddomains do
  microapp     = import(:spidy_expireddomains, :microapp)
  app_settings = microapp.settings
  stories      = microapp.stories

  is_app_initialize    = 0
  is_app_bootstrap     = 0
  is_open_git          = 0
  is_customisations    = 0

  settings do
    name                "#{parent.key}"
    type                "#{parent.type}"
    template_rel_path   'spider-js'
    description         app_settings.description
  end

  instructions :initialize_app do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    row '.gitignore'

  end

  instructions :bootstrap_app do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    row 'sheet.js'
    row 'index.js'
    row 'index_puppeteer.js', output: 'index.js'
  end

  instructions :custom do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'compare'), f(:after_write, 'open')]

    row 'README.md'#, conflict: 'overwrite'
    row '.rubocop.yml'
  end

  actions do
    if is_app_initialize == 1
      run_command 'npm init -y'
      run_command 'npm i google-spreadsheet moment node-fetch cheerio --save'
      # run_command 'npm i google-spreadsheet moment puppeteer --save'
      run_blueprint blueprint: :initialize_app      , microapp: microapp, settings: app_settings, stories: stories
    end

    # run_blueprint blueprint: :bootstrap_app       , microapp: microapp, settings: app_settings, stories: stories          if is_app_bootstrap == 1
    write_json is_edit: true
  end
end
