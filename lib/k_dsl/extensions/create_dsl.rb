module KDsl
  module Extensions
    module CreateDsl

      def new_microapp(name, **opts)
        create_dsl(name, :microapp, **opts)
      end

      # Create a new Klue DSL file from a Definition file
      #
      # This extension helps you to create new DSL's that follow predefined definitions.

      # Create a new DSL based on type
      #
      # @type = type of defination
      #         See: MICROAPP_TYPES & TYPES
      # @name = name of the new structure
      # @definition_subfolder = subfolder to find a definition for new DSL
      # @output_filename = file to write to, relative to output folder
      # @rel_path = alter output folder to be relative to root output folder
      # @opts = hash of options that can processed
      # @opts[:definition_name] = name of definition file in .definion directory to read from when creating new klue files
      # @opts[:output_folder] = over ride the out file, the default is usualling the folder of the Klue file that just ran
      def create_dsl(name, type, **opts)
        return warn('CreateDSL Skipped: Document not linked to a project') if !defined?(project) || project.nil?

        # _/_template/domain.rb
        definition_subfolder = if opts.key?(:definition_subfolder)
          opts[:definition_subfolder]
        else
          type.to_s
        end

        L.kv 'Definition SubFolder', definition_subfolder

        # project.config.debug

        definition_folder = File.join(project.config.base_definition_path, definition_subfolder)
        L.kv 'Definition Folder', definition_folder

        definition_name = if opts.key?(:definition_name)
          opts[:definition_name]
        else
          type.to_s
        end

        L.kv 'Definition Name', definition_name

        definition_file = File.expand_path("#{definition_name}.rb", definition_folder)
        L.kv 'Definition File', definition_file
        # BUG: actions are being fired for secondarily loaded files

        output_folder = if opts.key?(:output_folder)
                          opts[:output_folder]
                        else
                          # FACTOR: THIS IS A GREAT IDEA
                          # File.dirname(Klue.register_instance.current_processing_file)
                          project.config.base_resource_path
                        end

        L.kv 'Output Folder', output_folder
                
        output_filename = if opts.key?(:output_filename)
                            opts[:output_filename]
                          else
                            "#{type}.rb"
                          end

        L.kv 'Output File Name', output_filename
                  
        show_editor = opts.key?(:show_editor) ? opts[:show_editor] : true

        if opts.key?(:output_subfolder)
          L.kv 'Output Subfolder', opts[:output_subfolder]
          output_folder = File.expand_path(opts[:output_subfolder], output_folder)
          L.kv 'Output Folder', output_folder
        end

        output_file = File.expand_path(output_filename, output_folder)
        L.kv 'Output File', output_file

        is_write = !File.exist?(output_file) || (opts.key?(:f) && opts[:f] == true) || (opts.key?(:force) && opts[:force] == true)
        L.progress

        L.kv 'is_write', is_write
        L.kv 'File.exists?(output_file)', File.exists?(output_file)
        L.kv 'opts[:f]', opts[:f]
        L.kv 'opts[:force]', opts[:f]

        if is_write
          # L.block 'Create new KLUE file'
          # L.kv 'Definition SubFolder', definition_subfolder
          # L.kv 'Definition Folder', definition_folder
          # L.kv 'Definition File', definition_file
          # L.kv 'Output File Name', output_filename
          # L.kv 'Output Folder', output_folder
          # L.kv 'Output File', output_file

          raise KDsl::Error, 'Definition file not found' unless File.exists?(definition_file)

          content = File.read(definition_file)

          # L.block content

          opts = {
            name: name
          }.merge(opts)

          L.json(opts)
          # L.progress

          # add_to_options(opts)

          L.progress
          L.kv 'Name', opts[:name]
          L.kv 'OPTS', opts

          L.progress
          L.line

          opt = KDsl::Util.data.to_struct(opts)

          # L.block content
          # Probabally want to use the underscore generator

          # unless type == :microapp
          #   content = eval('"' + content + '"')
          # end

          # puts opts
          content = content#Klue.process_template(content, opts)

          # if type == :microapp
          #   puts opts
          #   content = Klue.process_template(content, opts)
          # else
          #   content = eval('"' + content + '"')
          # end
          # L.block content

          FileUtils.mkdir_p(File.dirname(output_file))

          File.write(output_file, content)

          # Would you like  run a code editor and open the created file. This should be configurable
          system("code -r #{output_file}") if show_editor
        end

        def add_to_options(opts)
          # attr_reader :k_key
          # attr_reader :type
          # attr_reader :options
          # attr_reader :meta_data
          return unless meta_data.keys
  
          meta_data.keys.each do |key|
            if opts.key?(key)
              L.kv 'Skipping Key', key
            else
              opts[key] = meta_data[key].clone
            end 
          end
        end
  
      end
    end
  end
end