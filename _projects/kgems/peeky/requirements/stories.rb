# ------------------------------------------------------------
# Ruby Commandlet Stories
# ------------------------------------------------------------

KDsl.document :stories do

  def on_action
    # write_json is_edit: true
  end

  table :stories do
    # status: :done, :current, :backlog:
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Developer, I can infer default paramater values, so that I have a deeper understanding of method usage',
    [
      'Add support default parameters'
    ]

    row :task, :done, 'As a Developer, I can use Peeky with a simple API, so that I use Peeky quickly',
      [
        'Add simplified API with examples',
        'Start documenting usage instructions'
      ]

    row :task, :done, 'As a Developer, I can quickly build requirements, so that I can document project features',
      [
        'Add support for backlog stories and tasks',
        'Add usage instructions'
      ]

    row :task, :done, 'As a Developer, I can render a class with RDoc documentation, so that I do not have to manually type RDoc references'
    
    row :story, :done, 'As a Developer, I can render a class with instance attributes and methods, So that I can quickly mock out an entire class',
      [
        'Render: Class Interface'
      ],
      featured_position: 2

    row :task, :done, 'As a Developer, I can read detailed API documentation on Peaky, so that I use Peeky quickly',
      [
        'Acid Test: Use the YARD renderer to document Peaky the GEM'
      ]

    row :story, :done, 'As a Developer, I can render method signature with debug code, So that mock out a method with parameter logging',
      [
        'Render: Method signature with debug code'
      ]

    row :story, :done, "As a Developer, I can see the method signature of a method, So that I understand it's parameters",
      [
        'Render: Method Signature in compact format'
      ]

    row :story, :done, 'As a Developer, I can render a method with minimal parameter calls, So that I know the minimum parameters when calling a method',
      [
        'Render: Simple instance method calls with minimum parameters'
      ],
      featured_position: 3

    row :story, :done, 'As a Developer, I can tell if a method is attr_*, so that I can format methods using attr_* notation',
      [
        'Attr Writer Predicate will match true if the method info could be considered a valid attr_writer',
        'Attr Writer Predicate will match true if the method info could be considered a valid attr_writer'
      ]

    row :story, :done, 'As a Developer, I should be able to interrogate class instance information, so that I can reverse engineer a ruby class',
      [
        'ParameterInfo model to store information about parameters on a method',
        'MethodInfo model to store signature of a ruby instance method',
        'AttrInfo is a container that represents attr_reader, attr_writer or attr_accessor by storying 1 or 2 MethodInfo',
        'ClassInfo stores information about a ruby class. Only support instance methods'
      ],
      featured_position: 1

    row :task, :done, 'Setup GitHub Action (test and lint)',
      [
        'Setup Rspec action',
        'Setup RuboCop action'
      ]

    row :task, :done, 'Setup new Ruby GEM',
        [
          'Build out a standard GEM structure',
          'Add semantic versioning',
          'Add Rspec unit testing framework',
          'Add RuboCop linting',
          'Add Guard for automatic watch and test',
          'Add GitFlow support',
          'Add GitHub Repository'
        ]
  end
end
