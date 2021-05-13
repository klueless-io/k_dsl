# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Platform, I need DRY/SRP types, so that the system maintains loose coupling',
    [
      'Add NamedFolders',
      'Add LayeredFolders'
    ], featured_position: 1

    row :task, :todo, 'Add debug methods to named_folders and layered folders'
    row :task, :todo, 'Get(:xxx) should not throw exception or there should at least be a way of checking if folder is available'
    

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/k_type)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/k_type/master)'
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
