# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Developer, I need manage github repositories, so that my code is version controlled

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :done, 'As a Developer, I want to manage github repositories, so that my code is version controlled',
    [
      'Create Repositories,',
      'Delete Repositories',
      'List Repositories'
    ], featured_position: 1

    row :story, :done, 'As a Developer, I can create a personal repository, so that my code is version controlled'
    row :story, :done, 'As a Developer, I can delete a personal repository, so that I can remove redundant code'
    row :story, :done, 'As a Developer, I can list of personal repositories, so that I know what projects I have'
    row :story, :done, 'As a Developer, I can create a organization repository, so that I have new repo under my organization'
    row :story, :done, 'As a Developer, I can delete a organization repository, so that I can remove redundant code from my organization'
    row :story, :done, 'As a Developer, I can list of organization repositories, so that I know what projects are available in the organization'

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/k_ext-github)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/k_ext-github/master)'
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
