KDsl.blueprint :ne do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'ne'
    description           "Ne: (not equal) Block helper that renders a block if `a` is **not equal to** `b`. If an inverse block is specified it will be rendered when falsy."
    result                "truthy value if left hand side is NOT equal to right hand side"
    category              'comparison'
    category_description  'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    # example_input_value   'the quick brown fox 99'
    # example_output_value  'TheQuickBrownFox99'
    # test_input_value      'the quick brown fox'
    # test_output_value     'TheQuickBrownFox'
    test_case(            { params: [
                              {name: 'lhs', type: 'String', sample_value: 'aaa', description: 'left hand side value'},
                              {name: 'rhs', type: 'String', sample_value: 'bbb', description: 'right hand side value'}
                            ],
                            example_output_value: 'Truthy'
                          })
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
