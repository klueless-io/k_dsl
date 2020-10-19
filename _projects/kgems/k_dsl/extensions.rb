KDsl.blueprint :extensions do
  microapp     = import(:k_dsl, :microapp)

  s = settings do
    name                'github_linkable'
    template_rel_path   'ruby-cmdlet'
  end

  blueprint do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row 'extension.rb'      , "lib/k_dsl/extensions/#{s.name}.rb"
    row 'extension_spec.rb' , "spec/extensions/#{s.name}_spec.rb"
  end

  actions do
    # run_blueprint
    # write_json is_edit: true
  end
end
