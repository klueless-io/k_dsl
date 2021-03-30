# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a C# Developer, I want to model a complex EF4 domain, so that I model real business logic

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a C# Developer, I can DO_SOMETHING, so that I QUALITY_OF_LIFE',
    [
      'Subtask'
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
          '(ToDo) Add automated semantic versioning',
          '(ToDo) Add XXXX unit testing framework',
          '(ToDo) Add XXXX linting',
          'Add local development watcher automatic watch and test',
          'Add GitFlow support',
          'Add GitHub Repository'
        ]
  end
end
