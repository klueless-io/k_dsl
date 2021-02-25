KDsl.blueprint :bootstrap_bin_hook do
  settings do
    name                parent.key
    type                parent.type
    template_rel_path   'csharp-console'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    # row '.gitignore'

    row 'bin/khotfix'
    row 'bin/kgitsync'

    row 'bin/runonce/common.sh'
    row 'bin/runonce/setup-chmod.sh', command: 'execute'
    row 'bin/runonce/setup-git.sh'  , command: 'execute'
  end

  is_run = 1

  def on_action
    run_blueprint microapp: import(:p03_domain_models, :microapp)
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
