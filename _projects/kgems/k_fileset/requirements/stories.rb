# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Developer, I want a path/file snapshot files on a computer, so I can access and manipulate files matching my pattern

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Developer, I want a path/file snapshot files on a computer, so I can access and manipulate files matching my pattern',
    [
      'Create a file set',
      'Have a whitelist of included files',
      'Have regex or glob patterns for excluded files'

    ], featured_position: 1

    row :task, :current, 'As a Developer, I want to add or remove files based on configured pattern (include/exclude) when files are added or removed from filesystem',
    [
      'Be able to add or remove files from the fileset'
    ]

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/k_fileset)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/k_fileset/master)'
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
