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
      Description for a basic example to be featured in the main README.MD file
    TEXT
      class SomeRubyExample
      end
    RUBY

    row :sample, 'Simple example', <<~TEXT, ruby: <<~RUBY
        Description for a simple example that shows up in the USAGE.MD
      TEXT
        class SomeRubyExample
          def initialize
          end
        end
      RUBY

  end
end
