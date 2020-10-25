KDsl.blueprint :extensions do
  microapp     = import(:k_dsl, :microapp)

  settings do
    name                parent.key
    type                parent.type
    template_rel_path   'ruby-cmdlet'
    description         microapp.settings.description
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    row 'xxx'
  end

  def on_action
    # write_json is_edit: true
  end
end
