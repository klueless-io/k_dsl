KDsl.blueprint :bootstrap_github_actions do
  settings do
    name                parent.key
    type                parent.type
    template_rel_path   'ruby-gem'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    # Setup CLI and command execution
    row '.github/workflows/main.yml'
  end

  is_run = 1

  def on_action
    run_blueprint microapp: import(:ruby_handlebars_helpers, :microapp)
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
