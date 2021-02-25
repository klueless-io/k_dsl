KDsl.blueprint :{{snake name}} do
  settings do
    name                parent.key
    type                parent.type
    template_rel_path   'webpack5'

    # Webpack Configuration, turn on with 1
    wp_entry            0
    wp_output           0
    wp_html_plugin      0
    wp_rule_image       0
    wp_rule_html        0
    wp_rule_css         0
    wp_rule_scss        0
    wp_rule_js_swc      1 # Prefer SWC over babel
    wp_rule_js_babel    0
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    row '.gitignore'

    row 'bin/khotfix'
    row 'bin/kgitsync'

    row 'bin/runonce/common.sh'
    row 'bin/runonce/setup-chmod.sh', command: 'execute'
    row 'bin/runonce/setup-git.sh'  , command: 'execute'

    row 'README.MD'

    row '.browserslistrc' # Not needed when using TypeScript

    row 'webpack.config.js', after_write: 'open'
  end

  is_run = 0

  def on_action
    run_blueprint microapp: import(:{{settings.name}}, :microapp)
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
