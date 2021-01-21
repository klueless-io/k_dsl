# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Ruby Developer, I want to document code usage examples, so that people can get going quickly with implementation

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Developer, I can DO_SOMETHING, so that I QUALITY_OF_LIFE',
    [
      'Subtask'
    ], featured_position: 1

    row :task, :current, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to rubygems.org',
      'Attach documentation to rubydoc.info'
    ]

    row :task, :done, 'Setup project management, requirement and planning documents',
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
          'Add semantic versioning',
          'Add Rspec unit testing framework',
          'Add RuboCop linting',
          'Add Guard for automatic watch and test',
          'Add GitFlow support',
          'Add GitHub Repository'
        ]
  end
end
