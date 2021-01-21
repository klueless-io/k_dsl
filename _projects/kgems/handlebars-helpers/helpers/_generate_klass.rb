KDsl.blueprint :_generate_klass do

  s = settings do
    name                'register_all_helpers'
    output_path         '/Users/davidcruwys/dev/kgems/handlebars-helpers/_/app/helpers'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'skip'), f(:after_write, 'open')]

    row 'klass.rb', "lib/handlebars/helpers/#{s.name}.rb"
    row 'klass_spec.rb', "spec/handlebars/helpers/#{s.name}_spec.rb"
  end

  is_run = 0

  def on_action
    # write_json is_edit: true
    run_blueprint microapp: import(:handlebars_helpers, :microapp)
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
