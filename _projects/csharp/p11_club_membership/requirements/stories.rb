# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Club Owner, I want to record and find member details, so I know who is in my club

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Club Owner, I want to record and find member details, so I know who is in my club',
    [
    ], featured_position: 1

    row :task, :done, 'Setup project management, requirement and SCRUM documents',
    [
      'Setup readme file',
      'Setup user stories and tasks',
      'Setup a project backlog',
      'Setup an examples/usage document'
    ]

    # row :task, :current, 'Setup GitHub Action (test and lint)',
    #   [
    #     'Setup Rspec action',
    #     'Setup RuboCop action'
    #   ]

    row :task, :done, 'Setup new C# console app',
        [
          'Build out a standard .net console application using C#',
          'Add linting using style cop',
          'Add local development watcher automatic watch and test',
          'Add GitFlow support',
          'Add GitHub Repository'
        ]
  end
end
