# Examples on how to use for inclusion into USAGE.MD
# ------------------------------------------------------------

KDsl.document :usage do
  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example  , :basic_example          , '', featured: true

    row :sample         , :sample_classes         , ''
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :basic_example, 'Basic example', <<~TEXT, ruby: <<~RUBY
      Render a template value using camel case and dasherize case
      TEXT
        Handlebars::Helpers::Template.render('{{camel .}}', 'david was here')
        # => "DavidWasHere"
        Handlebars::Helpers::Template.render('{{dasherize .}}', 'david was here')
        # => "david-was-here"
      RUBY

    row :sample, 'Simple example', <<~TEXT, ruby: <<~RUBY
        Render a template value using camel case and dasherize case
      TEXT
        Handlebars::Helpers::Template.render('{{camel .}}', 'david was here')
        # => "DavidWasHere"
        Handlebars::Helpers::Template.render('{{dasherize .}}', 'david was here')
        # => "david-was-here"
      RUBY

  end
end
