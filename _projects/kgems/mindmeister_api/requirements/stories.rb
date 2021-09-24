# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Developer, I need to read and write mindmaps from Mindmeister, so I automate workflows

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    # API Get MindMap as Document Hierarchy
    # Printer for Document Hierarchy
    # Print properties that are new to the document
    # Print Me

    row :story, :current, 'As a Developer, I can DO_SOMETHING, so that I QUALITY_OF_LIFE',
    [
      'Subtask'
    ], featured_position: 1

    row :task, :current, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/mindmeister_api)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/mindmeister_api/master)'
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
