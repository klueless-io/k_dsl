KDsl.blueprint :and do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'and'
    description           'And: Block helper that renders a block if **all of** the given values are truthy. If an inverse block is specified it will be rendered when falsy.'
    result                "return block when every value is truthy"
    category              'comparison'
    category_description  'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.'
    base_class_require    'handlebars/helpers/comparison/base_helper'
    base_class            'Handlebars::Helpers::Comparison::BaseHelper'
    example_input_value   'var1 and var2'
    example_output_value  'truthy block'
    test_input_value      'var1 and var2'
    test_output_value     'truthy block'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'skip'), f(:after_write, 'open')]

    row 'helper.rb'     , File.join(microapp.settings.app_path, 'lib' , 'handlebars', 'helpers', s.category.underscore, "#{s.name}.rb")
    row 'helper_spec.rb', File.join(microapp.settings.app_path, 'spec', 'handlebars', 'helpers', s.category.underscore, "#{s.name}_spec.rb")
  end

  is_run = 1

  def on_action
    # a = import(:handlebars_helpers, :microapp)
    # write_json is_edit: true
    run_blueprint microapp: import(:handlebars_helpers, :microapp)
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
