# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As an Application Developer, I need a rich and configurable ERD schema, so I can generate enterprise applications quickly

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Developer, I can print any of the domain structures, so that I can visually my domain',
    [
      'Hook up log.structure'
    ], featured_position: 1

    row :task, :current, 'Move Rails-Structure into domain->models', []

    row :task, :current, 'Create printers for domain->models->behaviours|functions', []

    row :story, :current, 'As a Developer, I can customize domain configuration, so that I can have opinions about names and types',
    [
      'Handle traits'
    ]

    row :task, :current, 'External ruby process - ShimLoading and ExtractModel',
    [
      'You need a clear memory foot print for shim loading and model extraction, best to run these from inside a new ruby process',
    ]

    row :task, :current, 'Log Warning to Investigate Issues',
    [
      'FIXED: All the logged warnings in k_domain need to turn up in on the investigate issues register',
      'Investigate needs a debug flag that when turned on, will write the issues to the console',
    ]

    row :task, :current, 'Print progress dot',
    [
      'Make this configurable',
      'Decide what steps this should run for',
      'Show step label via configuration'
    ]

    # DONE

    row :task, :done, 'BUGs in domain_model load',
    [
      'spec/k_domain/domain_model/load_spec.rb:135',
      'module_name should be empty',
      'name mismatch (attr_accessor, attr_reader, attr_writer) in behaviours vs in (attr_accessors, attr_readers, attr_writers) functions',
      'functions - (attr_accessors, attr_readers, attr_writers) are all empty'
    ]

    row :task, :done, 'Refactor / Simply',
    [
      'Replace complex objects with structs for ancillary data structures such as investigate',
    ]

    row :task, :done, 'Steps to support write methods on base class',
    [
      'Simplify lib/k_domain/domain_model/transform.rb'
    ]

    row :story, :done, 'As a Developer, I can read native rails model data, so that I can leverage existing rails applications for ERD modeling',
    [
      'Proof of concept',
      'Use Meta Programming and re-implement ActiveRecord::Base'
    ]

    row :task, :done, 'User acceptance testing',
    [
      'Provide sample printers for each data structure to visually check data is loading',
      'Point raw_db_schema loader towards a complex ERD and check how it performs',
    ]

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/k_domain)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/k_domain/master)'
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
