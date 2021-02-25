KDsl.blueprint :garden do
  microapp     = import(:p02ef4, :microapp)

  s = settings do
    name                    :garden
    output_rel_path         ''
    template_rel_path       'csharp-console'
    template_base_name      'Model'
    application_namespace   [microapp.settings.namespace_root, 'Models']
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row "Models/#{s.template_base_name}.cs"      , "Models/#{s.name.to_s.camelize}.cs"
    # row "#{s.template_base_name}_spec.rb" , "spec/P02Ef4#{out_path}/#{s.name}_spec.rb"
  end

  table :attributes do
    fields [:name, f(:type, :string)]

    row :name
  end

  def on_action
    run_blueprint microapp: import(:p02ef4, :microapp)

    write_json is_edit: true
  end
end
