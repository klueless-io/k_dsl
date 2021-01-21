# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Ruby Developer, I want to use HandlebarsJS with useful helpers, so that I have a rich templating experience

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current, :todo
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    # row :story, :current, 'As a Developer, I can DO_SOMETHING, so that I QUALITY_OF_LIFE',
    # [
    #   'xxxx'
    # ]
    
    row :story, :current, 'As a Developer, I can have string case formatting helpers, so that I can generate code and documentation using handlebars',
    [
    ]

    row :story, :current, 'As a Developer, I have flexible and modular formatters, so that I can format data into a new format',
    [
      'Define formatter categories, https://github.com/helpers/handlebars-helpers has 20 categories',
      'Create modular formatters with tests',
      'Provide a lazy loading technique to load formatters on an as needed basis'
    ], featured_position: 1

    row :story, :done, 'As a Developer, I can easily render Handlebar Templates, so that I am more efficient',
    [
      'Build simplified API for rendering templates'
    ], featured_position: 1

    row :story, :done, 'As a Developer, I can alias existing helpers, so that I have helper names that make sense to me',
    [
      'Provide a flexible mechanism for template aliases'
    ]

    row :story, :done, 'As a Developer, I can load specific groups of helpers, so that memory consumption can be minimized',
    [
      'Lazy load ruby helpers on an as needed basis'
    ], featured_position: 2

    row :task, :done, 'String tokenizer that formats input strings in a consistent fashion',
      [
        'Setup a single opinionated string tokenizer',
        'Make the string tokenizer configurable so it can be replaced with a different opinionated tokenizer'
      ]
  
    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      "Build and deploy gem to [rubygems.org](https://rubygems.org/gems/handlebars-helpers)",
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/klueless-io/handlebars-helpers/master)'
    ]

    row :task, :done, 'Setup GitHub Action (test and lint)',
      [
        'Setup Rspec action',
        'Setup RuboCop action'
      ]

    row :task, :done, 'Setup project management, requirement and SCRUM documents',
      [
        'Setup readme file',
        'Setup user stories and tasks',
        'Setup a project backlog',
        'Setup an examples/usage document'
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
