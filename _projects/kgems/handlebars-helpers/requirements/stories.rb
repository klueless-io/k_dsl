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

    #----------------------------------------------------------------------
    # CURRENT
    #----------------------------------------------------------------------


    row :task, :current, 'add support for environment variables', [ ]
    row :task, :current, 'klueless:', [
      'array_has_key_value',
      'includes settings.ModelType array AdminUser BasicUser, include?',
      'default_value if empty',
      'template comment, how can I have content in a template that is not written to the output file',
      'quote_and_ljust',
      'padd by object.length',
      'join using comma or other char',
      "{{padr (surround . '' ':') 40}} does not work?",
      "need support for curly_open/close"
    ]

    row :task, :current, 'wrap string in single/double quotes', [ ]

    row :task, :current, 'add support for string_formatter usage via STRING_FORMATTER.md', [ ]

    row :task, :current, 'add array/enumerable support, in particular take(array, limit)'
    row :task, :current, 'add array/enumerable support, in particular filter_variant(array, ...)'

    row :task, :current, 'titleize to support :symbols, and other methods need to be checked'

    row :task, :current, "add nil/empty handlers, such as nil to '', or nil to nil || 'xyz', '' to nil", [ ]

    row :task, :current, 'add factory methods so that I can just use any helper from Ruby Code',
    [
      'Handlebars::Helpers::StringFormatting::Camel.new.parse to string_helper.camel.parse()',
    ]


    row :task, :current, 'add gem release rake task (see k_builder-watch', [ ]

    row :story, :current, 'As a Documentor, I can create usage examples for this GEM, so that I can document the project',
    [
      'setup rspec-usage for the project',
      'create templates for generating slide decks',
      'record videos on how to use'
    ]

    row :story, :current, 'As a Developer, I can release a new version of the GEM, so that the updated Gem appears on rubygems and rubydoc',
    [
      'gem release',
      'research automated solution, eg. rake',
      'implement the solution'
    ]

    row :story, :current, 'As a Developer, I have flexible and modular formatters, so that I can format data into a new format',
    [
      'Define formatter categories, https://github.com/helpers/handlebars-helpers has 20 categories',
      'Create modular formatters with tests'
    ], featured_position: 1

    #----------------------------------------------------------------------
    # DONE
    #----------------------------------------------------------------------

    row :task, :done, 'check camel P02E04 has correct formatting',
    [
      'tested alpha-numeric coded value with word separation (p02_ef4 > P02Ef4)',
      'tested alpha-numeric coded value without word separation (p02ef4 > P02ef4)'
    ]

    row :task, :current, 'add support for category and helper count to readme.md',
    [
    ]

    row :story, :done, 'As a Developer, I can easily render Handlebar Templates, so that I am more efficient',
    [
      'Build simplified API for rendering templates'
    ], featured_position: 1

    row :story, :done, 'As a Developer, I can have string case formatting helpers, so that I can generate code and documentation using handlebars',
    [
    ]

    row :task, :done, 'add support for misc helper category',
    [
      'add noop/raw helper',
      'add safe helper'
    ]

    row :task, :done, 'refactor inflections namespace',
    [
      'Move pluralize and singularize to inflections',
      'Add support for ordinalize case, eg. 1st, 2nd, 3rd, 4th',
      'Add support for ordinal case, eg. st, nd, rd, th',
    ]

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
