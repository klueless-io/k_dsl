KDsl.blueprint :bed do
  microapp     = import(:p02ef4, :microapp)

  s = settings do
    name                    :bed
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
    fields [:name, f(:type, :string), f(:relation, nil)]

    row :number     , :int
    row :garden_id  , :int
  end

  table :old_fields do
    fields [:name, f(:type, 'String'), f(:title, "''"), f(:default,'null'), f(:required, true), :reference_type, :db_type, :format_type, :description]
    
    row :id                       , 'PrimaryKey'  , db_type: 'primarykey'
    row :user                     , 'ForeignKey'  , db_type: 'references' 
    row :badge_set                , 'ForeignKey'  , db_type: 'references' 
    row :progress                                 , db_type: 'jsonb'
  end

  #  type: :record
  table :relations do
    fields [:name, :name_plural, :field, :type, :json, :main_key, :td_key1, :td_key2, :td_key3, :through]

    one2one  user
    one2one  badge_set
    one2many badge_attainment
  end

  def on_action
    run_blueprint microapp: import(:p02ef4, :microapp)

    write_json is_edit: true
  end
end
