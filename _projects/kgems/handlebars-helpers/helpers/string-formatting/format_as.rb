KDsl.blueprint :format_as do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'format_as'
    description           "Format As: Chain a list of string formatters to run sequentially"
    result                "returns a value that has been processed by multiple formatters"
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
                              {name: 'value', type: 'String', sample_value: 'the quick brown fox', description: 'value to format'},
                              {name: 'formats', type: 'String', sample_value: 'pluralize,dashify', description: 'comma delimited list of formats'}
                            ],
                            example_output_value: 'the-quick-brown-foxes'
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
