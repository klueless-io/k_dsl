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

    row :task, :todo, 'Add a new type of group called group which will support different meta attributes'

    row :task, :todo, 'Rename usecase to base_group move into a namespace called groups',
    [
      'Groups take on the same role as Rspec::ExampleGroup',
      'Ensure that Usecase still exists but is decoupled and extends from BaseGroup'
    ]

    row :task, :todo, 'Rename documentor to generator'

    row :story, :current, 'As a Developer, I can generate documentation in various formats, so that I easily document ruby applications',
    [
      'Build Documentor with flexible renderer plugins'
    ], featured_position: 1

    row :story, :current, 'As a Developer, I can build documentable usecases, so that I easily document usage examples',
    [
      'Build Usecase'
    ], featured_position: 2

    row :story, :todo, 'Add logging support',
    [
      'Google best practice: add logging to a gem'
    ]

    row :story, :current, 'As a Developer, I can build documentation presentations, so that I can create videos quickly',
    [
      'https://revealjs.com/',
      'https://mofesolapaul.github.io/sectionizr/'
    ]

    row :story, :done, 'As a Developer, I can extend Rspec with code specific documentation extensions, so that I easily build documentation that parses unit tests'

    row :story, :done, 'As a Developer, I can have component based renderers, so that I easily extend documentation output renders',
    [
      'Build JSON renderer',
      'Build Debug renderer',
      'Build Markdown renderer'
    ]

    row :story, :done, 'Remove cooline and jazz_fingers gem from github actions by running from env variable',
    [
      'On Mac ```export RUBY_DEBUG_DEVELOPMENT=true```'
    ]

    row :story, :done, 'As a Developer, I can extract code and other content from unit test, so that I can inject it into documentation',
    [
      'Build Content, ContentCode an ContentOutcome'
    ]

    row :task, :done, 'Move content.* into a namespace called contents',
    [
      'Content items take on the same role as Rspec::Example'
    ]

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/rspec-usecases)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/rspec-usecases/master)'
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
