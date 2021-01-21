KDsl.blueprint :demodulize do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'demodulize'
    description           "Demodulize: Removes the module part from the expression in the string."
    result                "value demodulize, aka class name without module"
    category              'code_ruby'
    category_description  'Ruby code handling routines'
    base_class_require    'handlebars/helpers/base_helper'
    base_class            'Handlebars::Helpers::BaseHelper'
    # base_class_require    'handlebars/helpers/code_ruby/base_helper'
    # base_class            'Handlebars::Helpers::CodeRuby::BaseHelper'
    # example_input_value   'the quick brown fox 99'
    # example_output_value  'TheQuickBrownFox99'
    # test_input_value      'the quick brown fox'
    # test_output_value     'TheQuickBrownFox'
    test_case(            { params: [
                              {name: 'value', type: 'String', sample_value: 'ActiveSupport::Inflector::Inflections', description: 'name of the ruby module and class name separated by ::'}
                            ],
                            example_output_value: 'Inflections'
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
