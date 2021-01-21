KDsl.blueprint :_generate_helper do

  s = settings do
    name                  'tableize'
    category              'code_ruby'
    category_description  'Ruby code handling routines'
    # category              'string-case-formatting'
    # category_description  'String manipulation methods for case formatting'
    # category              'comparison'
    # category_description  'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.'
    # category              'string-formatting'
    # category_description  'General purpose string manipulation helpers'
    output_path           '/Users/davidcruwys/dev/kgems/handlebars-helpers/_/app/helpers'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'skip'), f(:after_write, 'open')]

    row 'new_helper_definition.rb', File.join(s.output_path, s.category, "#{s.name}.rb"), conflict: 'overwrite'
  end

  is_run = 1

  def on_action
    # write_json is_edit: true
    run_blueprint microapp: import(:handlebars_helpers, :microapp)
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
