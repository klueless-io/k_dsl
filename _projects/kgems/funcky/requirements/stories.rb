# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Developer, I want easy to use categorized functions, so I can easily run common functional actions

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Developer, I want easy to use simple categorized functions, so I can easily add commonplace functionality to my application',
    [
      'Create a list of categories',
      'Populate categories with functions',
    ], featured_position: 1

    row :task, :current, 'Research these links and build a list of categories and functions',
    [
      'https://handlebarsjs.com/guide/#installation',
      'https://github.com/helpers/handlebars-helpers',
      'https://github.com/klueless-io/handlebars-helpers',
      'https://rubygems.org',
      'https://www.ruby-toolbox.com/categories',
      'https://github.com/magynhard/lucky_case',
      'https://www.ruby-toolbox.com/projects/sanitize',
      '',
    ]

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/funcky)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/funcky/master)'
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
