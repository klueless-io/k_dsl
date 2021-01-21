KDsl.blueprint :foreign_key do
  microapp = import(:handlebars_helpers, :microapp)

  s = settings do
    name                  'foreign_key'
    description           "Foreign Key: Creates a foreign key name from a class name\n+separate_class_name_and_id_with_underscore+ sets whether\nthe method should put '_' between the name and 'id'."
    result                "value converted to separate_class_name_and_id_with_underscore"
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
                              {name: 'class_name', type: 'String', sample_value: 'Message', description: 'name of class'},
                              {name: 'class_id_underscored', type: 'Boolean', sample_value: 'true', description: 'is the class and ID separated by underscore?'}
                            ],
                            example_output_value: 'message_id'
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
