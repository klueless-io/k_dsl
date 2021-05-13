# Examples on how to use for inclusion into USAGE.MD
# ------------------------------------------------------------

KDsl.document :usage do
  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example  , :basic_example          , '', featured: true

    row :sample         , :sample_classes         , ''
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :basic_example, 'Layered Folder', <<~TEXT, ruby: <<~RUBY
      Layered folders allow files to be found in any of the searchable folders, it uses a `LIFO` stack ("Last-In, First-Out")
    TEXT

    base_folder = '/dev'
    
    app_template_folder = File.join(base_folder, 'app-template')
    domain_template_folder = File.join(base_folder, 'domain-template')
    global_template_folder = File.join(base_folder, 'global-template')

    folders = KType::LayeredFolders.new
    
    folders.add(:fallback  , '~/x')
    folders.add(:global    , global_template_folder)
    folders.add(:domain    , domain_template_folder)
    folders.add(:app       , app_template_folder)
    folders.add(:app_abc   , :app, 'a', 'b', 'c')

    # Find a file in one of the following folders, searches in the following order (LIFO)
    #
    # "/dev/app-template/a/b/c"
    # "/dev/app-template"
    # "/dev/domain-template"
    # "/dev/global-template"
    # "/Users/username/x"
    folders.find_file('template1.txt')

    # Get the folder that the file is found in
    #
    folders.find_file_folder('template1.txt')
    # > /dev/app-template
  
    RUBY

    row :basic_example, 'Named Folder', <<~TEXT, ruby: <<~RUBY
      Named folders allow folders to be stored with easy to remember names and alias's
    TEXT

    folders = KType::NamedFolders.new

    folders.add(:app    , '/dev/MyApp')
    folders.add(:config , :app, 'config')
    folders.add(:docs   , '~/documentation')

    # Creates named folders
    #
    # "/dev/MyApp"
    # "/dev/MyApp/config"
    # "/Users/username/documentation"

    # Get filename

    folders.get_filename(:app, 'Program.cs')
    # > '/dev/MyApp/Program.cs'

    folders.get_filename(:config, 'webpack.json')
    # > '/dev/MyApp/config/webpack.json'

    folders.get_filename(:app, 'Models', 'Person.cs')
    # > '/dev/MyApp/Models/Person.cs'

    # Get folder

    folders.get(:config)
    # > '/dev/MyApp/config'

    RUBY


    row :sample, 'Layered Folder', <<~TEXT, ruby: <<~RUBY
      Layered folders allow files to be found in any of the searchable folders, it uses a `LIFO` stack ("Last-In, First-Out")
    TEXT

    base_folder = '/dev'
    
    app_template_folder = File.join(base_folder, 'app-template')
    domain_template_folder = File.join(base_folder, 'domain-template')
    global_template_folder = File.join(base_folder, 'global-template')

    folders = KType::LayeredFolders.new
    
    folders.add(:fallback  , '~/x')
    folders.add(:global    , global_template_folder)
    folders.add(:domain    , domain_template_folder)
    folders.add(:app       , app_template_folder)
    folders.add(:app_abc   , :app, 'a', 'b', 'c')

    # Find a file in one of the following folders, searches in the following order (LIFO)
    #
    # "/dev/app-template/a/b/c"
    # "/dev/app-template"
    # "/dev/domain-template"
    # "/dev/global-template"
    # "/Users/username/x"
    folders.find_file('template1.txt')

    # Get the folder that the file is found in
    #
    folders.find_file_folder('template1.txt')
    # > /dev/app-template
  
    RUBY

    row :sample, 'Named Folder', <<~TEXT, ruby: <<~RUBY
      Named folders allow folders to be stored with easy to remember names and alias's
    TEXT

    folders = KType::NamedFolders.new

    folders.add(:app    , '/dev/MyApp')
    folders.add(:config , :app, 'config')
    folders.add(:docs   , '~/documentation')

    # Creates named folders
    #
    # "/dev/MyApp"
    # "/dev/MyApp/config"
    # "/Users/username/documentation"

    # Get filename

    folders.get_filename(:app, 'Program.cs')
    # > '/dev/MyApp/Program.cs'

    folders.get_filename(:config, 'webpack.json')
    # > '/dev/MyApp/config/webpack.json'

    folders.get_filename(:app, 'Models', 'Person.cs')
    # > '/dev/MyApp/Models/Person.cs'

    # Get folder

    folders.get(:config)
    # > '/dev/MyApp/config'

    RUBY

  end
end
