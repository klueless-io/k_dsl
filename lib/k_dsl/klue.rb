# frozen_string_literal: true

module KDsl
  # Klue-Less generator
  #
  class Extras
    # OTHER_TYPES = %i[cmd].freeze
    # MICROAPP_TYPES = %i[microapp domain blueprint structure].freeze
    # DOMAIN_TYPES = %i[entity value_object app_settings command]
    # TYPES = MICROAPP_TYPES | DOMAIN_TYPES | OTHER_TYPES

    attr_reader :key
    attr_reader :type
    attr_reader :namespace
    attr_reader :options


    # def blueprint(name = :instructions, &block)
    #   table(name, &block)
    # end
    
    # def command_args(name = :args, &block)
    #   table(name, &block)
    # end

    def actions(&block)
      # return if Klue.register_instance.current_state == :register_files

      # if Klue.register_instance.current_processing_file.nil?
      #   L.kv 'Skipping Actions', k_key
      #   return
      # end

      # L.kv 'Run Actions', k_key

      # begin
      #   self.instance_eval(&block) if block_given?
      # rescue => exception
      #   L.heading "Invalid code block in document_dsl: #{k_key}"
      #   L.exception exception
      #   raise
      # end
    end

    def import(k_key, k_type = :entity, namespace = nil)
      # data = Klue.register_instance.get_data(k_key, namespace, k_type)
      # result = DocumentDsl.to_struct(data)
    end

    def method_missing(name, *args, &block)
      puts 'yyyyyyyyyyyyyyyyyyyyyyy'
      # L.block 'artifact_dsl.method_missing'
      # L.kv 'name', name
      # L.kv 'value', args[0]
      super
    end

    def respond_to_missing?(name, *args)
      # # puts 'respond_to_missing?'
      # # puts 'name' + name
      # super
    end

    def debug(include_header = false)
      # if include_header
      #   L.heading 'Document DSL'
      #   L.kv 'k_key', k_key
      #   L.kv 'type', type

      #   options&.keys&.each do |key|
      #     L.kv key, options[key]
      #   end

      #   L.line
      # end
      # # tp dsls.values, :k_key, :k_type, :state, :save_at, :last_at, :data, :last_data, :source, { :file => { :width => 150 } } 
      # puts JSON.pretty_generate(meta_data)
    end

    def get_node_type(node_name)
      # node_data = @meta_data[node_name]

      # raise "Node not found: #{node_name}" if node_data.nil?

      # if node_data.keys.length == 2 && (node_data.key?(:fields) && node_data.key?(:rows))
      #   :rows
      # else
      #   :settings
      # end
    end

    def get_data()
      # data = {}

      # meta = meta_data

      # meta.keys.each do |key|
      #   if get_node_type(key) == :rows
      #     data[key] = meta[key][:rows]
      #   else
      #     data[key] = meta[key]
      #   end
      # end

      # data
    end

    def self.to_struct(data)
      # if data.is_a?(Hash)
      #   return OpenStruct.new(data.map { |k,v| [k, to_struct(v)] }.to_h )

      # elsif data.is_a?(Array)
      #   return data.map { |o| to_struct(o) }

      # else
      #   # Assumed to be a primititve value
      #   return data
        
      # end
    end

    def meta_data()
      @meta_data.clone
    end

    def write_json(is_edit: false)
      # output_file = "#{dsl_relative_path}/#{k_key}_#{type}.json"
      # # L.block "write_json #{output_file}"
      # write_data output_file, is_edit: is_edit
    end

    # write_data "#{dsl_relative_path}/#{s.model}.json"
    # write_data "#{dsl_relative_path}/#{s.model}.yaml"
    def write_data(file, as_type: nil, is_edit: false)
      # write_as(get_data, file, as_type, is_edit)
    end

    def write_meta_json(is_edit: false)
      # output_file = "#{dsl_relative_path}/#{k_key}_#{type}-meta.json"
      # # L.block "write_json #{output_file}"
      # write_meta output_file, is_edit: is_edit
    end

    # write_meta "#{dsl_relative_path}/#{s.model}-meta.json"
    # write_meta "#{dsl_relative_path}/#{s.model}-meta.yaml"
    def write_meta(file, as_type: nil, is_edit: false)
      # write_as(meta_data, file, as_type, is_edit)
    end

    def dsl_relative_path
      # dsl = Klue.register_instance.get_dsl(k_key, namespace, type)

      # raise Klue::Dsl::DslNotFoundError, 'DSL not found, run registration' if dsl.nil?

      # raise Klue::Dsl::DslNotFileRelatedError, 'DSL cannot be saved to file - source should be :file' if dsl[:source].nil? || dsl[:source] != :file
      # raise Klue::Dsl::DslNotFileRelatedError, 'DSL cannot be saved to file - provide a file' if dsl[:file].nil?
      # raise Klue::Dsl::DslNotFileRelatedError, 'DSL cannot be saved to file - provide a rel_folder' if dsl[:rel_folder].nil?

      # dsl[:rel_folder]
    end

    # ------------------------------------------------------------
    # The following methods really need to be in their own specialized
    # classes that extend DocumentDsl, they exist specifically for
    # KlueDsls
    # ------------------------------------------------------------

    def delete_folder(folder)
      # folder = File.expand_path(folder)
      # L.kv 'delete_folder', folder
      # FileUtils.remove_dir(folder)
    end

    def run_structure(**opts)
      # L.kv 'run_structure(**opts)', 'GO RICKY'
      # # puts opts

      # raise Klue::Dsl::DslInvalidTypeError, 'This command can only be called from a DSL of type :structure' if type.nil? || type != :structure

      # structure = DocumentDsl.to_struct(get_data)

      # # Structures run of a table called instuctions by default, 
      # # but if you want multi instructions in your configuration then you can 
      # # pass in an :blueprint option
      # if opts[:blueprint]
      #   instructions = structure[opts[:blueprint]]
      # else
      #   instructions = structure.instructions
      # end

      # # Add any custom structure settings onto the options
      # opts[:structure_settings] = structure.settings

      # raise Klue::Dsl::DslError, 'Structure requires instructions' if instructions.nil?
      # # I think this is now not needed (OR it needs to be linked to get_microapp)
      # # raise Klue::Dsl::DslError, 'Structure must be linked to an applet' if structure.settings.applet.nil?

      # microapp = get_microapp

      # microapp_data = get_microapp_data(microapp)

      # common_template_path = Klue.register_instance.base_template_path
      # app_template_path = Klue.register_instance.base_app_template_path

      # common_template_path = File.join(common_template_path, structure.settings.rel_path) if structure.settings.present? && structure.settings.rel_path.present?

      # # TODO: This needs to move out of structure settings and into app_settings
      # # NOTE: Originally this was just a alias for rel_path above, but rel_path above should remain as a struture specific option
      # common_template_path = File.join(common_template_path, structure.settings.template_rel_path) if structure.settings.present? && structure.settings.template_rel_path.present?

      # # TODO: This needs to move out of structure settings and into app_settings
      # app_template_path = File.join(app_template_path, structure.settings.template_app_path) if structure.settings.present? && structure.settings.template_app_path.present?

      # L.kv 'common_template_path', common_template_path
      # L.kv 'app_template_path', app_template_path

      # run_structure_instructions(instructions, microapp_data, common_template_path, app_template_path, opts)

    end

    # A structure object really holds a list of blueprints for execution,
    # so I am removing run_structure, in place of run_blueprint
    alias run_blueprint run_structure

    def run_structure_instructions(instructions, microapp_data, common_template_path, app_template_path, **opts)

      # opts[:microapp_settings] = microapp_data.settings
      
      # instructions.each do |instruction|
      #   iif = instruction.if || 'true'
      #   next unless eval(iif)
        
      #   needs_template = instruction.command.casecmp('generate').zero?

      #   raise Klue::Dsl::DslError, 'Template name not found on structure instructions' if needs_template && instruction.template_name.nil?

      #   # remove this if we plan to run in memory commands
      #   raise Klue::Dsl::DslError, 'Output file name not found on structure instructions' if instruction.output.nil?

      #   instruction.conflict = 'skip' unless instruction.conflict
      #   instruction.after_write = '' unless instruction.after_write

      #   if instruction.template_name.nil?
      #     template_file = nil
      #   else
      #     app_template_file = File.join(app_template_path, instruction.template_name)
      #     template_file = File.exists?(app_template_file) ? app_template_file : File.join(common_template_path, instruction.template_name)
      #   end

      #   if template_file
      #     L.line
      #     L.kv 'template_file', template_file
      #     L.kv 'template_file_exist', File.exist?(template_file)
      #   end

      #   raise Klue::Dsl::DslError, "Template not found. \n#{template_file}\n#{app_template_file}" if needs_template && !File.exist?(template_file)

      #   output_file = instruction.output
      #   output_file = output_file.gsub(/\$TEMPLATE_NAME\$/i, instruction.template_name) if instruction.template_name

      #   if opts[:output_file_tokens]
      #     opts[:output_file_tokens].keys.each do |key|
      #       value = opts[:output_file_tokens][key]
      #       output_file = output_file.gsub(/#{key}/, value)
      #     end
      #   end

      #   output_file = File.expand_path(output_file, microapp_data.settings.app_path)

      #   L.kv 'microapp.app_path', microapp_data.settings.app_path
      #   L.kv 'output_file', output_file
      #   L.kv 'output_file_exist - before', File.exist?(output_file)
      #   L.kv 'command', instruction.command

      #   if instruction.command.casecmp('delete').zero?
      #     if File.exist?(output_file)
      #       File.delete(output_file) 

      #       L.kv 'remove file', output_file
      #     end

      #     next
      #   end

      #   if instruction.command.casecmp('mkdir').zero?
      #     FileUtils.mkdir_p(output_file)
      #     next
      #   end

      #   run_structure_instruction(instruction, template_file, output_file, opts)

      #   raise Klue::Dsl::DslError, 'Output file not found' if !File.exist?(output_file)

      #   execute_output_file output_file, :system  if instruction.command.casecmp('execute').zero?
      #   execute_output_file output_file, :fork    if instruction.command.casecmp('fork').zero?

      #   L.kv 'output_file_exist - after', File.exist?(output_file)

      # end

    end

    def run_structure_instruction(instruction, template_file, output_file, **opts)
      # FileUtils.mkdir_p(File.dirname(output_file))

      # template = File.read(template_file)

      # output = Klue.process_template(template, opts)

      # is_exist = File.exist?(output_file)
      # is_write = false
      # is_new   = false

      # if is_exist
      #   if instruction.conflict.casecmp('skip').zero?
      #     L.kv 'ACTION WHEN FILE EXISTS', 'SKIPPING'
      #   end

      #   if instruction.conflict.casecmp('compare').zero?
      #     file = Tempfile.new
      #     file.write(output)
      #     file.close
      #     L.kv 'temp file', file.path
      #     is_write = true
      #     is_new = true

      #     if File.read(output_file) != output
      #       L.kv 'ACTION WHEN FILE EXISTS', 'COMPARE'
      #       system("code -d #{file.path} #{output_file}")
      #     else
      #       L.kv 'ACTION WHEN FILE EXISTS', 'COMPARE - SAME'
      #     end
      #   end

      #   if instruction.conflict.casecmp('overwrite').zero?
      #     is_write = true
      #     L.kv 'ACTION WHEN FILE EXISTS', 'OVER WRITING'
      #     File.write(output_file, output)
      #   end

      # else
      #   File.write(output_file, output)
      # end
      
      # if instruction.after_write.casecmp('open').zero? ||
      #   (is_write && instruction.after_write.casecmp('open_if_write').zero?) ||
      #   (is_new && instruction.after_write.casecmp('open_if_new').zero?)
      #   system("code #{output_file}")
      # end
    end

    def execute_output_file(output_file, execution_context)
      # L.kv 'execute_output_file', output_file

      # Dir.chdir File.dirname(output_file) do

      #   # cd bar && RBENV_VERSION=$(rbenv local) bundle -v
      #   # system "RBENV_VERSION=2.6.3 bash #{output_file}"
      #   system "RBENV_VERSION=2.6.5 /usr/local/bin/zsh #{output_file}" if execution_context == :system
      #   fork { exec("RBENV_VERSION=2.6.5 /usr/local/bin/zsh #{output_file}") } if execution_context == :fork

      # end
    end

    def run_command(command, command_creates_top_folder: false)
      # L.kv 'Run command', command

      # microapp = get_microapp

      # microapp_data = get_microapp_data(microapp)

      # output_path = File.expand_path(microapp_data.settings.app_path)

      # L.kv 'Target path', output_path

      # if command_creates_top_folder
      #   # Strip the last path because the command running will take care of last path creation
      #   output_path = File.dirname(output_path)
      # end

      # FileUtils.mkdir_p(output_path)

      # build_command = "cd #{output_path} && #{command}"

      # L.kv 'Run command in path', build_command
      
      # system(build_command)
      # # fork { exec(build_command) } 
    end

    def new_microapp(name, rel_path = '.', **opts)
      # klue_new(:microapp, name, :microapp, "microapp.rb", rel_path, opts)
    end

    # This is really just an architype (maybe)
    def new_domain(name, rel_path = '.', **opts)
      # klue_new(:domain, name, :domain, "domain.rb", rel_path, opts)
    end

    # This is really just an architype
    def new_app_settings(name = 'app_settings', rel_path = 'artifacts', **opts)
      # klue_new :app_settings, name, :archetype, "app_settings.rb", rel_path, opts
    end

    # This is really just an architype
    def new_entity(name, rel_path = 'artifacts', **opts)
      # klue_new :entity, name, :entity, "#{name}.rb", rel_path, opts
    end

    def new_archetype(name, type, rel_path = 'artifacts', namespace: '', **opts)
      # opts = {} if opts.nil?
      # opts[:archetype_name] = name
      # opts[:archetype_type] = type
      # opts[:archetype_namespace] = namespace

      # output_filename = opts[:output_filename] || "#{name}.rb"

      # klue_new type, name, :archetype, output_filename, rel_path, opts
    end

    def new_structure(name, rel_path = 'structures', **opts)
      # opts = {} if opts.nil?
      # opts[:structure_name] = name

      # output_filename = opts[:output_filename] || "#{name}.rb"

      # klue_new :structure, name, :structure, output_filename, rel_path, opts
    end

    def open_file(file_name)
      # system("code #{file_name}")
    end

    # Create a new Klue DSL file from a Definition file
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
    def klue_new(type, name, definition_subfolder, output_filename, rel_path = nil, **opts)
      # # _/_template/domain.rb
      # definition_subfolder = definition_subfolder.to_s
      # definition_folder = File.join(Klue.register_instance.base_definition_path, definition_subfolder)

      # definition_name = type.to_s
      # definition_name = opts[:definition_name] if opts.key?(:definition_name)

      # definition_file = File.expand_path("#{definition_name}.rb", definition_folder)
      # # BUG: actions are being fired for secondarily loaded files

      # output_folder = if opts.key?(:output_folder)
      #                   opts[:output_folder]
      #                 else
      #                   File.dirname(Klue.register_instance.current_processing_file)
      #                 end

      # show_editor = opts.key?(:show_editor) ? opts[:show_editor] : true

      # if rel_path.present?
      #   output_folder = File.expand_path(rel_path, output_folder)
      # end

      # output_file = File.expand_path(output_filename, output_folder)

      # is_write = !File.exist?(output_file) || (opts.key?(:f) && opts[:f] == true)

      # L.kv 'is_write', is_write
      # L.kv 'File.exists?(output_file)', File.exists?(output_file)
      # L.kv 'opts[:f]', opts[:f]

      # if is_write
      #   L.block 'Create new KLUE file'
      #   L.kv 'Definition SubFolder', definition_subfolder
      #   L.kv 'Definition Folder', definition_folder
      #   L.kv 'Definition File', definition_file
      #   L.kv 'Output File Name', output_filename
      #   L.kv 'Output Folder', output_folder
      #   L.kv 'Output File', output_file

      #   raise Klue::Dsl::DslError, 'Definition file not found' unless File.exists?(definition_file)

      #   content = File.read(definition_file)

      #   opts = { 
      #     name: name
      #   }.merge(opts)

      #   add_to_options(opts)

      #   L.kv 'Name', opts[:name]
      #   L.kv 'OPTS', opts

      #   L.line

      #   opt = DocumentDsl.to_struct(opts)

      #   # L.block content
      #   # Probabally want to use the underscore generator

      #   # unless type == :microapp
      #   #   content = eval('"' + content + '"')
      #   # end

      #   # puts opts
      #   content = Klue.process_template(content, opts)

      #   # if type == :microapp
      #   #   puts opts
      #   #   content = Klue.process_template(content, opts)
      #   # else
      #   #   content = eval('"' + content + '"')
      #   # end
      #   # L.block content

      #   FileUtils.mkdir_p(File.dirname(output_file))

      #   File.write(output_file, content)

      #   # Would you like  run a code editor and open the created file. This should be configurable
      #   system("code -r #{output_file}") if show_editor
      # end

    end

    def get_microapp
      # microapps = Klue.register_instance.get_dsls_by_type(:microapp)

      # raise Klue::Dsl::DslError, 'Microapp required' if microapps.empty?
      # raise Klue::Dsl::DslError, 'Only one Microapp allowed' if microapps.length > 1

      # microapps.first
    end

    def get_microapp_data(microapp)
      # hash = Klue.register_instance.load_data_from_dsl(microapp)
      # data = DocumentDsl.to_struct(hash)
      # data.settings.app_path_expanded = File.expand_path(data.settings.app_path)
      # data
    end

    private

    def processor
      @processor ||= KDsl::Decorator::Processor.new
    end
    
    def quote_and_ljust(value, size)
      # "'#{value}'".ljust(size, ' ')
    end

    def add_to_options(opts)
      # # attr_reader :k_key
      # # attr_reader :type
      # # attr_reader :options
      # # attr_reader :meta_data
      # return unless meta_data.keys

      # meta_data.keys.each do |key|
      #   if opts.key?(key)
      #     L.kv 'Skipping Key', key
      #   else
      #     opts[key] = meta_data[key].clone
      #   end 
      # end

    end

    def write_as(data, file, as_type = nil, is_edit = false)

      # full_file = File.expand_path(file, Klue.register_instance.base_data_path)

      # if as_type.nil?
      #   ext = File.extname(full_file)
      #   as_type = :yaml if ext.casecmp('.yaml').zero? || ext.casecmp('.yml').zero?
      #   as_type = :json if ext.casecmp('.json').zero?
      # end

      # # L.kv 'file', file
      # # L.kv 'ext', ext
      # # L.kv 'as_type', as_type

      # raise 'Provide a valid extension or as_type. Supported types: [json, yaml]' unless [:json, :yaml].include?(as_type)

      # FileUtils.mkdir_p(File.dirname(full_file))

      # File.write(full_file, JSON.pretty_generate(data)) if as_type == :json
      # File.write(full_file, data.to_yaml)               if as_type == :yaml

      # system("code #{full_file}") if is_edit
    end
  end
end