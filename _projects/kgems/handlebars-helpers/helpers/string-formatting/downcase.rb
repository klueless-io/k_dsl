KDsl.blueprint :downcase do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'downcase'
    description           "Downcase/Lowercase all of the characters in the given string."
    result                "value in lowercase"
    category              'string-case-formatting'
    category_description  'String manipulation methods for case formatting'
    # base_class_require    'handlebars/helpers/string_case_formatting/base_helper'
    # base_class            'Handlebars::Helpers::StringCaseFormatting::BaseHelper'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    example_input_value   'The Quick Brown Fox 99'
    example_output_value  'the quick brown fox 99'
    test_input_value      'The Quick Brown Fox'
    test_output_value     'the quick brown fox'
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
