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

    row :basic_example, 'Console Helpers', <<~TEXT, ruby: <<~RUBY
      Generate encoded strings that have meaning in the console
    TEXT

    puts KUtil.console.hyperlink('Google', 'https://google.com')

    # "Google"
    # (clickable hyperlink to the google website)

    puts KUtil.console.file_hyperlink('My File', '/somepath/my-file.txt')

    # "My File"
    # (clickable link to the a file in the file system)

    RUBY

    row :basic_example, 'Data Helpers', <<~TEXT, ruby: <<~RUBY
    Data object helpers such as any object to open struct and any object to hash
  TEXT
   ThunderBirds = Struct.new(:action)

    virgil = OpenStruct.new(name: 'Virgil Tracy', age: 73, thunder_bird: ThunderBirds.new(:are_grounded))
    penny = OpenStruct.new(name: 'Lady Penelope', age: 69, thunder_bird: ThunderBirds.new(:are_go))

    data = {
      key1: 'David',
      key2: 333,
      key3: ThunderBirds.new(:are_go),
      people: [virgil, penny]
    }

    data_open = KUtil.data.to_open_struct(data)
    data_hash = KUtil.data.to_hash(data_open)
    
    puts JSON.pretty_generate(data_hash)

    # {
    #   "key1": "David",
    #   "key2": 333,
    #   "key3": {
    #     "action": "are_go"
    #   },
    #   "people": [
    #     {
    #       "name": "Virgil Tracy",
    #       "age": 73,
    #       "thunder_bird": {
    #         "action": "are_grounded"
    #       }
    #     },
    #     {
    #       "name": "Lady Penelope",
    #       "age": 69,
    #       "thunder_bird": {
    #         "action": "are_go"
    #       }
    #     }
    #   ]
    # }
    RUBY

    row :basic_example, 'File Helpers', ruby: <<~RUBY

    puts KUtil.file.expand_path('file.rb')

    # /current/folder/file.rb

    puts KUtil.file.expand_path('/file.rb')

    # /file.rb

    puts KUtil.file.expand_path('~/file.rb')

    # /Users/current-user/file.rb

    puts KUtil.file.expand_path('file.rb', '/klue-less/xyz')

    # /klue-less/xyz/file.rb

    puts KUtil.file.pathname_absolute?('somepath/somefile.rb')

    # false

    puts KUtil.file.pathname_absolute?('/somepath/somefile.rb')

    # true

    RUBY

    row :sample, 'Console Helpers', <<~TEXT, ruby: <<~RUBY
      Generate encoded strings that have meaning in the console
    TEXT

    puts KUtil.console.hyperlink('Google', 'https://google.com')

    # "Google"
    # (clickable hyperlink to the google website)

    puts KUtil.console.file_hyperlink('My File', '/somepath/my-file.txt')

    # "My File"
    # (clickable link to the a file in the file system)

    RUBY

    row :sample, 'File Helpers', <<~TEXT, ruby: <<~RUBY
    TEXT

    # Expand Path
    
    puts KUtil.file.expand_path('file.rb')

    # /current/folder/file.rb

    puts KUtil.file.expand_path('/file.rb')

    # /file.rb

    puts KUtil.file.expand_path('~/file.rb')

    # /Users/current-user/file.rb

    puts KUtil.file.expand_path('file.rb', '/klue-less/xyz')

    # /klue-less/xyz/file.rb

    # Absolute path/file name

    puts KUtil.file.pathname_absolute?('somepath/somefile.rb')

    # false

    puts KUtil.file.pathname_absolute?('/somepath/somefile.rb')

    # true

    RUBY

    row :sample, 'Data Helpers', <<~TEXT, ruby: <<~RUBY
      Data object helpers such as any object to open struct and any object to hash
    TEXT

    ThunderBirds = Struct.new(:action)

    virgil = OpenStruct.new(name: 'Virgil Tracy', age: 73, thunder_bird: ThunderBirds.new(:are_grounded))
    penny = OpenStruct.new(name: 'Lady Penelope', age: 69, thunder_bird: ThunderBirds.new(:are_go))

    data = {
      key1: 'David',
      key2: 333,
      key3: ThunderBirds.new(:are_go),
      people: [virgil, penny]
    }

    data_open = KUtil.data.to_open_struct(data)
    data_hash = KUtil.data.to_hash(data_open)
    
    puts JSON.pretty_generate(data_hash)

    # {
    #   "key1": "David",
    #   "key2": 333,
    #   "key3": {
    #     "action": "are_go"
    #   },
    #   "people": [
    #     {
    #       "name": "Virgil Tracy",
    #       "age": 73,
    #       "thunder_bird": {
    #         "action": "are_grounded"
    #       }
    #     },
    #     {
    #       "name": "Lady Penelope",
    #       "age": 69,
    #       "thunder_bird": {
    #         "action": "are_go"
    #       }
    #     }
    #   ]
    # }
    RUBY

  end
end
