# Track user-stories and tasks (in progress and done)
# ------------------------------------------------------------

KDsl.document :stories do
  # Epic:
  # As a Polyglot Developer, I want to be up and running in any development language with consistency, so I am productive and using best practices

  def on_action
    # write_json is_edit: true
  end

  # featured_position: 1
  table :stories do
    # status: :done, :current
    fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    row :story, :current, 'As a Polyglot Developer, I want to be up and running in any development language with consistency, so I am productive and using best practices [EPIC]',
    [
    ], featured_position: 1

    row :task, 'add if(true) concept, eg.',
    [
      "builder.if(true).add_file('only-adds-file-if-true.txt')"
    ]
    row :task, 'log(:debug, :other_target)',
    [
      "add_file and other methods need logging capability"
    ]

    row :story, :current, 'As a Developer, I need the builder API easier to use, so I am more efficient',
    [
      'Add file parts into layered and named folders',
      'Add content_file got support for looking up in template folders, but it did not get a unit test',
      'BUG BIG ONE, should content file be reading from template folders? and what happens when content file is absolute',
      'Add variant that writes to clipboard called add_clipboard',
      'TargetFile, needs support for absolute target_file',
      'Touch as an alias for add_file with no content',
      'Add vscode support',
      'Add_file needs to support folder_key',
      'Delete folder, so that I can regenerate a complete folder without leftover artifacts',
      'Add vscode compare support',
      'Add vscode last target_file support',
      'Add vscode last template_file support',
      'A TF variable support. add_file with template_file: needs to support optional filename that is the same as the template_file (or use a token, eg. $TF_PATH$, $TF_NAME$, $TF_FILE$',
      'need to support the fork process options as I was not able to run k_builder_watch -n because it hid all the following output',
      'Need support for rubocop -a'
    ]

    row :story, :current, 'BACKLOG: As a Developer, I need builders to be easier to use, so I am more efficient',
    [
      'Folder Key, also need support for template_folder_key',
      'cb (change_back) method which is the opposite of cd (change_dir)',
      'cd needs to support subfolders, but this will mean that the target folder system will need to allow for relative path concepts',
      'It would be useful to have two configurations, one for new code and the other for new builders',
      '* wild card support for add_file, maybe call it add_files or copy files',
      'Xml File Update for .csproj',
      'add_file, the files being generated are not being logged',
      'Path relative to: So a project folder, relative to a solution folder',
      'File relative to: So a project file, relative to a solution file'
    ]

    row :task, :current, 'EventStore - Will store events for each builder action',
    [
      'Define event types',
      'Define event structures',
      'Add event',
      'Find last event',
      'Find last event by type',
      'Find penultimate event by type',
      'Find all events by type',
    ]

    row :story, :current, 'As a Developer, I need event logging, so I can debug my builder configurations',
    [
      'Log of files added and their content',
      'help(file) will open the file specified in vscode',
      'helpme will toggle help on, or maybe we do help(file) as a logged link and helpme(file) as an open file',
      'Template errors need to log the template and the filename',
      'Logging needs to be more informative',
      'builder.on_error { builder }.log_errors'
    ]

    <<~RUBY
    .add_file("#{project[:key]}/setup-project.rb"       , template_file: 'bld-csharp/setup-project.rb')
    .add_file("#{project[:key]}/_.rb"                   , template_file: 'bld-csharp/config/_.rb')
    .add_file("#{project[:key]}/_data-entities.rb"      , template_file: 'bld-csharp/config/_data-entities.rb')
    .add_file("#{project[:key]}/_data.rb"               , template_file: 'bld-csharp/config/_data.rb')
    .add_file("#{project[:key]}/_initialize.rb"         , template_file: 'bld-csharp/config/_initialize.rb')
    .add_file("#{project[:key]}/_opinions.rb"           , template_file: 'bld-csharp/config/_opinions.rb')
    .add_file("#{project[:key]}/_structures.rb"         , template_file: 'bld-csharp/config/_structures.rb')

    # to

    .add_file("#{project[:key]}/$TEMPLATE_NAME$"        , template_file: 'bld-csharp/setup-project.rb')
    .add_file("#{project[:key]}/config/$TEMPLATE_NAME$" , template_file: 'bld-csharp/config/_.rb')
    .add_file("#{project[:key]}/config/$TEMPLATE_NAME$" , template_file: 'bld-csharp/config/_data-entities.rb')
    .add_file("#{project[:key]}/config/$TEMPLATE_NAME$" , template_file: 'bld-csharp/config/_data.rb')
    .add_file("#{project[:key]}/config/$TEMPLATE_NAME$" , template_file: 'bld-csharp/config/_initialize.rb')
    .add_file("#{project[:key]}/config/$TEMPLATE_NAME$" , template_file: 'bld-csharp/config/_opinions.rb')
    .add_file("#{project[:key]}/config/$TEMPLATE_NAME$" , template_file: 'bld-csharp/config/_structures.rb')
    RUBY

    row :story, :todo, 'As a Developer, I want to intelligently generate my next builder, so I can flow into creating the next component type',
    [
      'Currently known as definitions, I think these may just be a different type of template/target pairing',
    ]

    row :task, :done, 'WatchBuilder - Build Watcher (as a builder) - [k_builder-watch](https://github.com/klueless-io/k_builder-watch)'
    row :task, :todo, 'AppBuilder'
    row :task, :todo, 'WebBuilder'
    row :task, :todo, '- PackageBuilder (done)'
    row :task, :todo, '- Webpack5Builder (started)'
    row :task, :todo, '- ReactBuilder'
    row :task, :todo, '- SlideDeckBuilder'
    row :task, :todo, '- JavascriptBuilder'
    row :task, :todo, 'SolutionBuilder'
    row :task, :todo, 'DotnetBuilder'
    row :task, :todo, '- C#Console'
    row :task, :todo, '- C#Mvc'
    row :task, :todo, 'GPT3Builder'
    row :task, :todo, 'RubyBuilder'
    row :task, :todo, '- RubyGem'
    row :task, :todo, '- RailsApp'
    row :task, :todo, 'PythonBuilder'
    row :task, :todo, 'DddBuilder'
    row :task, :todo, '- DddGenerator'

    row :task, :done, 'Refactor BaseBuilder'

    row :story, :done, 'As a Developer, I want have multiple template, so I can group my templates by area of specialty',
    [
      'Refactor global and app templates to a layered folder array using (First In, Last Out) priority',
      'Support subfolders of any template folder (maybe)'
    ]

    row :story, :done, 'As a Developer, I want have multiple output folders, so I can write to multiple locations',
    [
      'Refactor output folder so that there are multiple named output folders, with :default working the same way as the existing system',
      'Support subfolders of any output folder',
      'Support output folder change of focus'
    ]

    row :task, :done, 'Setup RubyGems and RubyDoc',
    [
      'Build and deploy gem to [rubygems.org](https://rubygems.org/gems/k_builder)',
      'Attach documentation to [rubydoc.info](https://rubydoc.info/github/to-do-/k_builder/master)'
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
