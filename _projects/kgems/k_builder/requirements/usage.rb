# Examples on how to use for inclusion into USAGE.MD
# ------------------------------------------------------------

KDsl.document :usage do
  def on_action
    # write_json is_edit: true
  end

  table :example_groups do
    fields [:key, :group, :description, f(:featured, false)]

    row :basic_example  , :basic_example          , '', featured: true

    row :sample         , 'Configure and Build'           , ''
  end

  table :examples do
    # status: :done, :current, :backlog:
    # fields [f(:type, :story), f(:status, :todo), :story, :tasks, f(:featured_position, 0)]

    fields [:group_key, :name, :description, :ruby]

    row :basic_example, 'Configure and Run', <<~TEXT, ruby: <<~RUBY
        Setup configuration for KBuilder

        Generate two files:
        
        1. main.rb is based on class.rb from app_template
        2. configuration.log.txt is based on an inline template

        Check out usage.md for more details

      TEXT
        usecases_folder = File.join(Dir.getwd, 'spec', 'usecases')

        KBuilder.configure do |config|
          config.template_folder = File.join(usecases_folder, '.app_template')
          config.global_template_folder = File.join(usecases_folder, '.global_template')
          config.target_folder = File.join(usecases_folder, '.output')
        end

        template = <<~TEXT
        Configured Template Folder        : {{a}}
        Configured Global Template Folder : {{b}}
        Configured Output Folder          : {{c}}
      TEXT

      builder = KBuilder::Builder.init

      builder
        .add_file('main.rb', template_file: 'class.rb', name: 'main')
        .add_file('configuration.log.txt',
                  template: template,
                  a: builder.template_folder,
                  b: builder.global_template_folder,
                  c: builder.target_folder)

      RUBY

    row :sample, '', 'Print the configuration', ruby: <<~RUBY
        usecases_folder = File.join(Dir.getwd, 'spec', 'usecases')

        KBuilder.configure do |config|
          config.template_folder = File.join(usecases_folder, '.app_template')
          config.global_template_folder = File.join(usecases_folder, '.global_template')
          config.target_folder = File.join(usecases_folder, '.output')
        end

        puts JSON.pretty_generate(KBuilder.configuration.to_hash)
      RUBY

    row :sample, '', <<~TEXT
      ```javascript
      {
        "target_folder": "/Users/name/dev/kgems/k_builder/spec/usecases/.output",
        "template_folder": "/Users/name/dev/kgems/k_builder/spec/usecases/.app_template",
        "global_template_folder": "/Users/name/dev/kgems/k_builder/spec/usecases/.global_template"
      }
      ```
    TEXT

    row :sample, 'Folder Structure (starting)', <<~TEXT, image: 'usage/_usage_folder_before.png'
      Example folder structure for this usecase before running the builder
    
      > Note: app-templates will take preference over global templates
    TEXT

    row :sample, 'Run builder', <<~TEXT, ruby: <<~RUBY
        This example builder will add 4 files into the output folder.

        1. `main.rb` is based on `class.rb` from `app_template`
        2. `person.rb` & `address.rb` are based on `model.rb` from `global_template`
        3. `configuration.log.txt` is based on an inline template
      TEXT

        template = <<~TEXT
          Configured Template Folder        : {{a}}
          Configured Global Template Folder : {{b}}
          Configured Output Folder          : {{c}}
        TEXT

        builder = KBuilder::Builder.init

        builder
          .add_file('main.rb', template_file: 'class.rb', name: 'main')
          .add_file('person.rb',
                    template_file: 'model.rb',
                    name: 'person',
                    fields: %i[first_name last_name])
          .add_file('address.rb',
                    template_file: 'model.rb',
                    name: 'address',
                    fields: %i[street1 street2 post_code state])
          .add_file('configuration.log.txt',
                    template: template,
                    a: builder.template_folder,
                    b: builder.global_template_folder,
                    c: builder.target_folder)
          .add_file('css/index.css',
                    template: '{{#each colors}} .{{.}} { color: {{.}} }  {{/each}}',
                    colors: ['red', 'blue', 'green'],
                    pretty: true)
    

      RUBY

    row :sample, 'Folder Structure (after)', <<~TEXT, image: 'usage/_usage_folder_after.png'
      Folder structure after running the builder
    TEXT

    row :sample, 'main.rb', image: 'usage/_out1.png'
    row :sample, 'person.rb', image: 'usage/_out2.png'
    row :sample, 'address.rb', image: 'usage/_out3.png'
    row :sample, 'configuration.log.txt', image: 'usage/_out4.png'
    row :sample, 'css/index.css', image: 'usage/_out5.png'

  end
end
