# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a C# Developer, I want a simple MVC app with bootstrap plugins, so that I practice web apps

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :done, 'As a C# Developer, I want a simple MVC app with bootstrap plugins, so that I practice web apps',
    [
      'Use JQuery Plugin - Animated-Off-Canvas-Navigation-Bootstrap-4',
      'Use JQuery Plugin - Feature-rich Data Table Plugin For Bootstrap',
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
          'Build out a standard .net mvc application using C#',
          'Add GitFlow support',
          'Add GitHub Repository'
        ]
  end
end
