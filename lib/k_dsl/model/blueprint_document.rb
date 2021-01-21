# frozen_string_literal: true

module KDsl
  module Model
    # A blueprint document holds a list of blueprint instructions for execution
    class BlueprintDocument < Document
      def instructions(name = :instructions, &block)
        table(name, &block)
      end

      def run_blueprint(**opts)

        L.heading 'run_blueprint(**opts)'

        opts[:project] = OpenStruct.new(config: project.config.to_struct)

        blueprint = self.raw_data_struct #DocumentDsl.to_struct(get_data)

        opts[:blueprint] = blueprint

        # Blueprints run of a table called instuctions by default, 
        # but if you want multi instructions in your configuration then you can 
        # pass in an :instructions option
        if opts[:instructions]
          instructions = blueprint[opts[:instructions]]
        else
          instructions = blueprint.instructions
        end

        raise KDsl::Error, 'Blueprint requires instructions' if instructions.nil?

        # IS THIS NEEDED?
        # microapp = get_microapp
        # microapps = project.get_resource_documents_by_type(:microapp)
        # raise KDsl::Error, 'Run command requires a microapp with target path' if microapps.empty?
        # raise KDsl::Error, 'Run command currently supports single MicroApp projects only' if microapps.length > 1
        # microapp_settings = microapps.first.document.data_struct.settings
        # microapp_data = get_microapp_data(microapp)

        # REFACT: This information is needed in write_html
        # REFACT: definition also needs an application specific definitions, this was found in the handlebars project
        opts[:template] = {
          common_template_path: project.config.base_template_path,
          app_template_path: project.config.base_app_template_path
        }

        if blueprint&.settings&.template_rel_path
          opts[:template][:common_template_path] = File.join(opts[:template][:common_template_path], blueprint.settings.template_rel_path)
        end

        # L.kv 'common_template_path (+rel)', common_template_path

        # L.kv 'common_template_path', common_template_path
        # L.kv 'app_template_path', app_template_path

        opt = KDsl::Util.data.to_struct(opts)

        # L.ostruct opt, skip_array: true

        run_blueprint_instructions(instructions.rows, opt)
      end

      def run_blueprint_instructions(instructions, opt)
        L.subheading 'run_blueprint_instructions'

        instructions.each do |instruction|
          L.kv 'template_name', instruction.template_name
          iif = instruction.if || 'true'

          L.kv 'run condition met', iif
          next unless eval(iif)

          needs_template = instruction.command.casecmp('generate').zero?

          raise KDsl::Error, 'Template name not found on structure instructions' if needs_template && instruction.template_name.nil?
          raise KDsl::Error, 'Output file name not found on structure instructions' if instruction.output.nil?

          instruction.conflict = 'skip' unless instruction.conflict
          instruction.after_write = '' unless instruction.after_write

          L.kv 'conflict', instruction.conflict
          L.kv 'after_write', instruction.after_write

          # ----------------------------------------------------------------------
          # What template file are we using
          # ----------------------------------------------------------------------

          opt.template.file = nil

          if instruction.template_name.present?
            # common_template_file = File.join(common_template_path, instruction.template_name)
            # common_template_file = KDsl::Util.file.expand_path(common_template_file, project.config.base_template_path)

            app_template_file = File.join(opt.template.app_template_path, instruction.template_name)
            app_template_file = KDsl::Util.file.expand_path(app_template_file, project.config.base_app_template_path)

            common_template_file = File.join(opt.template.common_template_path, instruction.template_name)
            common_template_file = KDsl::Util.file.expand_path(common_template_file, project.config.base_template_path)
            
            opt.template.file = File.exists?(app_template_file) ? app_template_file : common_template_file

            atf_found = File.exist?(app_template_file) ? 'found' : 'not found'
            ctf_found = File.exist?(common_template_file) ? 'found' : 'not found'
                    
            L.line
            L.kv "app_template_file [#{atf_found}]", KDsl::Util.data.console_file_hyperlink(app_template_file, app_template_file)
            L.kv "common_template_file [#{ctf_found}]", KDsl::Util.data.console_file_hyperlink(common_template_file, common_template_file)
            L.line
          end

          if needs_template && !File.exist?(opt.template.file)
            tf_found = File.exist?(opt.template.file)

            L.line
            L.kv "template_file #{tf_found}", KDsl::Util.data.console_file_hyperlink(opt.template.file, opt.template.file)
            L.line

            raise KDsl::Error, "Template not found. \n#{opt.template.file}\n#{opt.template.file}"
          end

          # ----------------------------------------------------------------------
          # Where are we writing to
          # ----------------------------------------------------------------------

          output_file = instruction.output
          output_file = output_file.gsub(/\$TEMPLATE_NAME\$/i, instruction.template_name) if instruction.template_name

          # Needs testing
          # if opts[:output_file_tokens]
          #   opts[:output_file_tokens].keys.each do |key|
          #     value = opts[:output_file_tokens][key]
          #     output_file = output_file.gsub(/#{key}/, value)
          #   end
          # end

          if opt.microapp&.settings&.app_path&.present?
            L.kv 'microapp.app_path', opt.microapp.settings.app_path
            output_file = File.expand_path(output_file, opt.microapp.settings.app_path)
          end

          out_found = File.exist?(output_file) ? 'found' : 'not found'

          L.kv "output_file [#{out_found}]", KDsl::Util.data.console_file_hyperlink(output_file, output_file)

          opt.output = OpenStruct.new file: output_file

          L.kv 'command', instruction.command

          if instruction.command.casecmp('delete').zero?
            if File.exist?(opt.output.file)
              File.delete(opt.output.file) 

              L.kv 'remove file', opt.output.file
            end

            next
          end

          if instruction.command.casecmp('mkdir').zero?
            FileUtils.mkdir_p(opt.output.file)
            next
          end

          run_blueprint_instruction(instruction, opt)

          raise KDsl::Error, 'Output file not found' if !File.exist?(opt.output.file)

          execute_output_file opt.output.file, :system  if instruction.command.casecmp('execute').zero?
          execute_output_file opt.output.file, :fork    if instruction.command.casecmp('fork').zero?

          L.kv 'output_file_exist - after', File.exist?(output_file)
          L.line character: '-'

        end

      end

      def run_blueprint_instruction(instruction, opt)
        FileUtils.mkdir_p(File.dirname(opt.output.file))

        template = File.read(opt.template.file)
        opt.instruction = instruction
        L.o opt
        output = KDsl::TemplateRendering::TemplateHelper.process_template(template, opt)

        is_exist = File.exist?(opt.output.file)
        is_write = false
        is_new   = false
        is_update= false

        if is_exist
          if instruction.conflict.casecmp('skip').zero?
            L.kv 'ACTION WHEN FILE EXISTS', 'SKIPPING'
          end
  
          if instruction.conflict.casecmp('compare').zero?
            file = Tempfile.new
            file.write(output)
            file.close
            L.kv 'temp file', file.path
            # is_write = true # THESE DON'T MAKE SENSE?
            # is_new = true

            if File.read(opt.output.file) != output
              L.kv 'ACTION WHEN FILE EXISTS', 'COMPARE'
              system("code -d #{file.path} #{opt.output.file}")
            else
              L.kv 'ACTION WHEN FILE EXISTS', 'COMPARE - SAME'
            end
          end

          if instruction.conflict.casecmp('overwrite').zero?
            is_write = true
            is_update = true
            L.kv 'ACTION WHEN FILE EXISTS', 'OVER WRITING'
            File.write(opt.output.file, output)
          end

        else
          is_write = true
          is_new = true
          File.write(opt.output.file, output)
        end

        after_write = instruction.after_write.split(',')
        
        if after_write.include?('format') || after_write.include?('cop') && is_write
          run_command "rubocop -a #{opt.output.file}"
        end

        if after_write.include?('prettier') && is_write
          run_command "prettier --check #{opt.output.file} --write #{opt.output.file}"
        end
  
        if after_write.include?('open') ||
          (is_write && after_write.include?('open_if_write')) ||
          (is_new && after_write.include?('open_if_new'))
          system("code #{opt.output.file}")
        end
        if after_write.include?('open_template')
          system("code #{opt.template.file}")
        end
      end

      def execute_output_file(output_file, execution_context)
        L.kv 'execute_output_file', output_file

        Dir.chdir File.dirname(output_file) do
          # cd bar && RBENV_VERSION=$(rbenv local) bundle -v
          # system "RBENV_VERSION=2.6.3 bash #{output_file}"
          # system "RBENV_VERSION=2.6.5 /usr/local/bin/zsh #{output_file}" if execution_context == :system
          # fork { exec("RBENV_VERSION=2.6.5 /usr/local/bin/zsh #{output_file}") } if execution_context == :fork
          system "/usr/local/bin/zsh #{output_file}" if execution_context == :system
          fork { exec("/usr/local/bin/zsh #{output_file}") } if execution_context == :fork
        end
      end
    end
  end
end
