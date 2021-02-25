KDsl.blueprint :player do
  microapp     = import(:p04_domain_monopoly_v1, :microapp)

  s = settings do
    name                    :player
    output_rel_path         ''
    template_rel_path       'csharp-console'
    template_base_name      'Model'
    application_namespace   [microapp.settings.namespace_root, 'Models']
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row "Models/#{s.template_base_name}.cs"           , "Models/#{s.name.to_s.camelize}.cs"
    row "Models/#{s.template_base_name}.designer.cs"  , "Models/#{s.name.to_s.camelize}.designer.cs"
  end

  table :attributes do
    fields [:name, f(:type, :string)]

    row :game_id, :int # derive from one2one

    row :name
  end

  table :relations do
    fields [:name, :name_plural, :field, :type, :json, :main_key, :td_key1, :td_key2, :td_key3, :through]

    # one2one  import(:game).settings
    # one2many import(:player).settings
    # one2many import(:square).settings
  end

  def on_action
    run_blueprint microapp: import(:p04_domain_monopoly_v1, :microapp)

    # write_json is_edit: true
  end
end
