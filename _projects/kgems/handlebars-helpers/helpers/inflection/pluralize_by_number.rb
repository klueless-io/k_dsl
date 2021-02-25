KDsl.blueprint :pluralize_by_number do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'pluralize_by_number'
    description           "Pluralize By Number: uses both a word and number to decide if the plural or singular form should be used."
    result                "value and number are used to calculate plural/singular form"
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
                              {name: 'value', type: 'String', sample_value: 'category', description: 'value to pluralize'},
                              {name: 'count', type: 'Integer', sample_value: 3, description: 'count used to determine pluralization'},
                              {name: 'format', type: 'String', sample_value: 'number_value', described_class: 'what format should output be. :word, :number_word'}
                            ],
                            example_output_value: '3 categories'
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
