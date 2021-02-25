KDsl.blueprint :surround do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'surround'
    description           "Surround will surround a value with prefix and suffix, empty value is considered valid data"
    result                "prefix + value + suffix"
    category              'string-formatting'
    category_description  'String manipulation methods for case formatting'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    # base_class_require    'handlebars/helpers/string_formatting/base_helper'
    # base_class            'Handlebars::Helpers::StringFormatting::BaseHelper'
    # example_input_value   'the quick brown fox 99'
    # example_output_value  'TheQuickBrownFox99'
    # test_input_value      'the quick brown fox'
    # test_output_value     'TheQuickBrownFox'
    test_case(            { params: [
                              {name: 'value', type: 'String', sample_value: 'product category', description: 'value to surround'},
                              {name: 'prefix', type: 'String', sample_value: '["', description: 'prefix to insert in front of value'},
                              {name: 'suffix', type: 'String', sample_value: '"]', description: 'suffix to append to value'},
                              {name: 'formats', type: 'String', sample_value: 'titleize', description: 'list of formats to apply to value, defaults to none'}
                            ],
                            example_output_value: '["Product Category"]'
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
