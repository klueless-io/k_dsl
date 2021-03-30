# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Developer, I need flexible data structures defined in DSL, so can model rich documents

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Developer, I need flexible data structures defined in DSL, so can model rich documents',
    [
    ], featured_position: 1

    row :task, :backlog, 'add DSL for settings'
    row :task, :backlog, 'add DSL for table and rows'
    row :task, :backlog, 'add DSL for data structure'
    row :task, :backlog, 'add document to wrap around the data structure'
    row :task, :backlog, 'add flexible builder DSS support'

    row :task, :current, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/k_doc)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/k_doc/master)'
    ]

    row :task, :done, 'Setup project management, requirement and SCRUM documents',
    [
      'Setup readme file',
      'Setup user stories and tasks',
      'Setup a project backlog',
      'Setup an examples/usage document'
    ]

    row :task, :current, 'Setup GitHub Action (test and lint)',
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
