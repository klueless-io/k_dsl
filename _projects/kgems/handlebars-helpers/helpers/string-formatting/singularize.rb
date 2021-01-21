KDsl.blueprint :singularize do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'singularize'
    description           "The reverse of #pluralize, returns the singular form of a word in a string"
    result                "plural value turned to singular value"
    category              'string-formatting'
    category_description  'General purpose string manipulation helpers'
    # base_class_require    'handlebars/helpers/string_case_formatting/base_helper'
    # base_class            'Handlebars::Helpers::StringCaseFormatting::BaseHelper'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    example_input_value   'names'
    example_output_value  'name'
    test_input_value      'octopi'
    test_output_value     'octopus'

    # example_input_value   'the quick brown fox 99'
    # example_output_value  'TheQuickBrownFox99'
    # test_input_value      'the quick brown fox'
    # test_output_value     'TheQuickBrownFox'
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
