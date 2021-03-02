# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a SPA Developer, I want to configure webpack5 enabled applications quickly, so I don&amp;#x27;t have to be a WebPack5 expert

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :task, :current, 'Main Steps',
    [
      'Context object that contains the target folder and configuration',
      'Create Package.json in a target folder',
      'Create Package.json based off a bunch of steps',
      '[Maybe NOT] Modify an existing package.json without blowing anything away',
      'Create supplementary files such as .browserslistrc',
      'Build a out a WebConfig'
    ], featured_position: 1

    # row :story, :current, 'As a Developer, I can DO_SOMETHING, so that I QUALITY_OF_LIFE',
    # [
    #   'Subtask'
    # ], featured_position: 1

    row :task, :current, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/webpack5-builder)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/webpack5-builder/master)'
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
