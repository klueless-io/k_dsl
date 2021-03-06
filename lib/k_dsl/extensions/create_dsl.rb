module KDsl
  module Extensions
    module CreateDsl

      # opts = {} if opts.nil?
      def new_microapp(name, **opts)
        opts[:definition_name] = :app unless opts.key?(:definition_name)
        opts[:output_subfolder] = name unless opts.key?(:output_subfolder)
        opts[:output_filename] = opts[:output_filename] || "#{opts[:definition_name]}.rb"
        
        create_dsl(name, :microapp, **opts)
      end
    
      # rel_path = 'structures', 
      def new_blueprint(name, **opts)
        opts[:definition_name] = name unless opts.key?(:definition_name)
        opts[:output_filename] = opts[:output_filename] || "#{name}.rb" # "#{opts[:definition_name]}.rb"

        create_dsl(name, :blueprint, **opts)
        # klue_new :structure, name, :structure, output_filename, rel_path, opts
      end

      # def new_archetype(name, type, rel_path = 'artifacts', namespace: '', **opts)
      def new_archetype(name, type, **opts) #, rel_path = 'artifacts', namespace: '', **opts)
        unless opts.key?(:definition_subfolders)
          if opts.key?(:definition_subfolder)
            opts[:definition_subfolders] = [opts[:definition_subfolder], :archetype]
          else
            opts[:definition_subfolders] = [:archetype]
          end
        end

        unless opts.key?(:output_subfolders)
          if opts.key?(:output_subfolder)
            opts[:output_subfolders] = [opts[:output_subfolder], :archetype]
          else
            opts[:output_subfolders] = [:archetype]
          end
        end

        opts[:output_filename] = opts[:output_filename] || "#{name}.rb" # "#{opts[:definition_name]}.rb"
        
        # opts = {} if opts.nil?
        # opts[:archetype_name] = name
        # opts[:archetype_type] = type
        # opts[:archetype_namespace] = namespace

        # output_filename = opts[:output_filename] || "#{name}.rb"

        # klue_new type, name, :archetype, output_filename, rel_path, opts

        create_dsl(name, type, **opts)
      end

      # ---------------------------------------------------------------------------
      # def new_archetype(name, type, rel_path = 'artifacts', namespace: '', **opts)
      #   opts = {} if opts.nil?
      #   opts[:archetype_name] = name
      #   opts[:archetype_type] = type
      #   opts[:archetype_namespace] = namespace

      #   output_filename = opts[:output_filename] || "#{name}.rb"

      #   klue_new type, name, :archetype, output_filename, rel_path, opts
      # end

      # def klue_new(type, name, definition_subfolder, output_filename, rel_path = nil, **opts)
      # ---------------------------------------------------------------------------


      # Create a new Klue DSL file from a Definition file
      #
      # This extension helps you to create new DSL's that follow predefined definitions.

      # Create a new DSL based on type
      #
      # @type = type of definition
      #         See: MICROAPP_TYPES & TYPES
      # @definition_subfolder = subfolder to find a definition for new DSL
      # @output_filename = file to write to, relative to output folder
      # @output_subfolder = alter output folder to be relative to root output folder
      # @opts = hash of options that can processed
      # @opts[:definition_name] = name of definition file in .definition directory to read from when creating new klue files
      # @opts[:output_folder] = over ride the out file, the default is usually the folder of the Klue file that just ran
      # REFACT: Use a structured params pattern at some time
      def create_dsl(name, type, **opts)
        L.heading "create_dsl: #{name}"
        return warn('CreateDSL Skipped: Document not linked to a project') if !defined?(project) || project.nil?

        # L.progress
        # _/_template/domain.rb
        definition_subfolder = if opts.key?(:definition_subfolder)
                                 opts[:definition_subfolder].to_s
                               else
                                 type.to_s
                               end

        definition_subfolders = if opts.key?(:definition_subfolders)
                                  opts[:definition_subfolders]
                                else
                                  [opts[:definition_subfolder]]
                                end

        definition_subfolders = [definition_subfolders] if definition_subfolders.is_a?(String) || definition_subfolders.is_a?(Symbol)
        definition_subfolders = definition_subfolders.map(&:to_s)
        # L.progress
        definition_folder = File.join(project.config.base_definition_path, *definition_subfolders)

        # L.progress
        definition_name = if opts.key?(:definition_name)
                            opts[:definition_name].to_s
                          else
                            type.to_s
                          end

        # L.progress
        definition_file = File.expand_path("#{definition_name}.rb", definition_folder)
        # BUG: actions are being fired for secondarily loaded files

        # L.progress
        output_folder = if opts.key?(:output_folder)
                          opts[:output_folder].to_s
                        else
                          # FACTOR: THIS IS A GREAT IDEA
                          # File.dirname(Klue.register_instance.current_processing_file)
                          project.config.base_resource_path
                        end

        output_subfolder = if opts.key?(:output_subfolder)
                             opts[:output_subfolder].to_s
                           else
                             ''
                           end

        output_subfolders = if opts.key?(:output_subfolders)
                              opts[:output_subfolders]
                            else
                              [opts[:output_subfolder]]
                            end

        output_subfolders = [output_subfolders] if output_subfolders.is_a?(String) || output_subfolders.is_a?(Symbol)
        output_subfolders = output_subfolders.map(&:to_s)

        if output_subfolders.length > 0
          output_folder = File.expand_path(File.join(output_subfolders), output_folder)
        end

        # L.progress
        output_filename = if opts.key?(:output_filename)
                            opts[:output_filename].to_s
                          else
                            "#{type}.rb"
                          end

        # L.progress
        show_editor = opts.key?(:show_editor) ? opts[:show_editor] : true
        # L.progress
        debug_only = opts.key?(:debug_only) ? opts[:debug_only] : false

        
        # L.progress
        # if opts.key?(:output_subfolder)
        #   output_folder = File.expand_path(opts[:output_subfolder].to_s, output_folder)
        # end

        # L.progress
        output_file = File.expand_path(output_filename, output_folder)

        # L.progress
        is_write = !File.exist?(output_file) || (opts.key?(:f) && opts[:f] == true) || (opts.key?(:force) && opts[:force] == true)

        # L.progress
        opts = {
          name: name
        }.merge(opts)

        add_to_options(opts)

        L.kv 'is_write', is_write
        L.kv 'File.exists?(output_file)', File.exists?(output_file)
        L.kv 'opts[:f]', opts[:f]
        L.kv 'opts[:force]', opts[:f]

        L.block 'Create new DSL - settings'
        L.kv 'Definition SubFolder', definition_subfolder
        L.kv 'Definition SubFolder(s)', definition_subfolders
        L.kv 'Definition Name', definition_name
        L.kv 'Definition Folder', definition_folder
        L.kv 'Definition File', definition_file
        L.line character: '-'
        L.kv 'Output Subfolder', opts[:output_subfolder]
        L.kv 'Output File Name', output_filename
        L.kv 'Output Folder', output_folder
        L.kv 'Output File', output_file
        L.line character: '-'
        L.kv 'Show Editor', show_editor
        L.kv 'Debug Only', debug_only
        L.kv 'File.exists?(definition_file)', File.exists?(definition_file)
        L.line character: '-'
        L.json(opts)
        # REFACT: All these params should be available in the opts hash

        raise KDsl::Error, "Definition file not found: #{definition_file}" unless File.exists?(definition_file)

        if is_write
          if debug_only
            L.subheading 'Create new DSL - Debug only'
            return
          end

          L.subheading 'Create new DSL'

          content = File.read(definition_file)
          content = KDsl::TemplateRendering::TemplateHelper.process_template(content, opts)
          # if type == :microapp
          #   puts opts
          #   content = Klue.process_template(content, opts)
          # else
          #   content = eval('"' + content + '"')
          # end
          # L.block content

          FileUtils.mkdir_p(File.dirname(output_file))

          File.write(output_file, content)
        else
          L.subheading 'Skip creation of new DSL'
        end

        L.kv 'Definition File', KDsl::Util.data.console_file_hyperlink(definition_file, definition_file)
        L.kv 'Output File', KDsl::Util.data.console_file_hyperlink(output_file, output_file)

        # Would you like  run a code editor and open the created file. This should be configurable
        system("code -r #{output_file}") if show_editor

        output_file
      end

      def add_to_options(opts)
        return unless data.keys

        data.keys.each do |key|
          if opts.key?(key)
            L.kv 'Skipping Key', key
          else
            L.kv 'Add To Options Key', key
            opts[key] = data[key].clone
          end 
        end
      end
    end
  end
end