# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Small Business Merchant, I want to calculate applicable tax and duties, so I am compliant with government regulations

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Small Business Merchant, I want to calculate applicable tax and duties, so I am compliant with government regulations',
    [
      'Read a data source, known as a shopping basket',
      'Convert data into a receipt with items',
      'Run tax and total calculations for the receipt',
      'Print out the receipt'

    ], featured_position: 1

    row :task, :done, 'Categorization Service',
    [
      'Infer a product category',
      'Infer if product is imported'
    ]

    row :task, :done, 'Create shopping cart report',
    [
      'Take raw information from csv data source',
      'Convert information to receipt + items',
      'Render a report to the console'
    ]

    row :task, :done, 'Create csv to item mapper',
    [
      'Map item data from csv file to type safe item class'
    ]

    row :task, :done, 'Create csv reader',
    [
      'Read headings and rows',
      'Clean up issues with spaces and empty lines'
    ]

    row :task, :done, 'Create a rounding module',
    [
      'Round to nearest 5 cents',
      'Round to nearest (other amount), eg. 10 cent, 50 cent for completeness'
    ]

    row :task, :done, 'Domain model: Receipt',
    [
      'Add receipt model',
      'Build calculations'
    ]

    row :task, :done, 'Domain model: Item',
    [
      'Add item model',
      'Support strong parameters',
      'Build calculations'
    ]

    row :task, :done, 'Setup project management, requirement and SCRUM documents',
    [
      'Setup readme file',
      'Setup user stories and tasks',
      'Setup a project backlog',
      'Setup an examples/usage document'
    ]

    row :task, :done, 'Setup GitHub Action (test and lint)',
      [
        'Setup Rspec action',
        'Setup RuboCop action'
      ]

    row :task, :done, 'Setup new Ruby GEM',
        [
          'Build out a standard GEM structure',
          'Add automated semantic versioning',
          'Add Rspec unit testing framework',
          'Add RuboCop linting',
          'Add Guard for automatic watch and test',
          'Add GitFlow support',
          'Add GitHub Repository'
        ]
  end
end
