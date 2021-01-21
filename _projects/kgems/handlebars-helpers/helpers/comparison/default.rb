KDsl.blueprint :default do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'default'
    description           "Default: Returns the first value that is not nil or undefined, otherwise the 'default' value is returned."
    result                "value or default value"
    category              'comparison'
    category_description  'Comparison helpers, eg. or, and, equal, not equal, less than, greater than etc.'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    # base_class_require    'handlebars/helpers/comparison/base_helper'
    # base_class            'Handlebars::Helpers::Comparison::BaseHelper'
    # example_input_value   'the quick brown fox 99'
    # example_output_value  'TheQuickBrownFox99'
    # test_input_value      'the quick brown fox'
    # test_output_value     'TheQuickBrownFox'
    test_case(            { params: [
                              {name: 'value'        , type: 'Object', sample_value: nil     , description: 'one or more paramaters that may or may not contain nil'},
                              {name: 'default_value', type: 'String', sample_value: 'happy' , description: 'the last paramater will be the default value'}
                            ],
                            example_output_value: 'happy'
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
