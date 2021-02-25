KDsl.blueprint :ordinal do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'ordinal'
    description           "Ordinal: The suffix that should be added to a number to denote the position in an ordered sequence such as 1st, 2nd, 3rd, 4th"
    result                "ordinal suffix that would be required for a number"
    category              'inflection'
    category_description  'Inflection handling routines, eg. pluralize, singular, ordinalize'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    # base_class_require    'handlebars/helpers/inflection/base_helper'
    # base_class            'Handlebars::Helpers::Inflection::BaseHelper'
    # example_input_value   'the quick brown fox 99'
    # example_output_value  'TheQuickBrownFox99'
    # test_input_value      'the quick brown fox'
    # test_output_value     'TheQuickBrownFox'
    test_case(            { params: [
                              {name: 'value', type: 'String', sample_value: '1', description: 'numeric value'}
                            ],
                            example_output_value: 'st'
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
