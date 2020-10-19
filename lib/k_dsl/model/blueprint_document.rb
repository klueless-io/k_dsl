# frozen_string_literal: true

module KDsl
  module Model
    # A blueprint document holds a list of blueprint instructions for execution
    class BlueprintDocument < Document
      def instructions(name = :instructions, &block)
        table(name, &block)
      end

      def blueprint(name = :instructions, &block)
        table(name, &block)
      end

      def run_blueprint(**opts)

        L.heading 'run_blueprint(**opts)'

        blueprint = self.raw_data_struct #DocumentDsl.to_struct(get_data)

        # Blueprints run of a table called instuctions by default, 
        # but if you want multi instructions in your configuration then you can 
        # pass in an :blueprint option
        if opts[:blueprint]
          instructions = blueprint[opts[:blueprint]]
        else
          instructions = blueprint.instructions
        end

        # Add any custom blueprint settings onto the options
        opts[:blueprint_settings] = blueprint.settings
        opts[:microapp_settings] = opts[:microapp]&.settings if opts[:microapp]&.settings.present?

        raise KDsl::Error, 'Blueprint requires instructions' if instructions.nil?
        # I think this is now not needed (OR it needs to be linked to get_microapp)
        # raise KDsl::Error, 'Blueprint must be linked to an applet' if blueprint.settings.applet.nil?

        # IS THIS NEEDED?
        # microapp = get_microapp
        # microapps = project.get_resource_documents_by_type(:microapp)
        # raise KDsl::Error, 'Run command requires a microapp with target path' if microapps.empty?
        # raise KDsl::Error, 'Run command currently supports single MicroApp projects only' if microapps.length > 1
        # microapp_settings = microapps.first.document.data_struct.settings
        # microapp_data = get_microapp_data(microapp)

        L.ostruct opts

        common_template_path = project.config.base_template_path
        app_template_path = project.config.base_app_template_path

        L.kv 'common_template_path', common_template_path
        L.kv 'app_template_path', app_template_path

        common_template_path = File.join(common_template_path, blueprint.settings.template_rel_path) if blueprint.settings.present? && blueprint.settings.template_rel_path.present?
        L.kv 'common_template_path (+rel)', common_template_path

        # AM I supposed to have both global (microapp) and (blueprint specific) relative paths?
        # # TODO: This needs to move out of blueprint settings and into app_settings
        # # NOTE: Originally this was just a alias for rel_path above, but rel_path above should remain as a struture specific option
        # common_template_path = File.join(common_template_path, blueprint.settings.template_rel_path) if blueprint.settings.present? && blueprint.settings.template_rel_path.present?

        run_blueprint_instructions(instructions.rows, common_template_path, app_template_path, **opts)
      end

      def run_blueprint_instructions(instructions, common_template_path, app_template_path, **opts)
        L.subheading 'run_blueprint_instructions'

        instructions.each do |instruction|
          L.kv 'template_name', instruction.template_name
          iif = instruction.if || 'true'

          L.kv 'run condition met', iif
          next unless eval(iif)

          needs_template = instruction.command.casecmp('generate').zero?

          raise KDsl::Error, 'Template name not found on structure instructions' if needs_template && instruction.template_name.nil?
          # remove this if we plan to run in memory commands
          raise KDsl::Error, 'Output file name not found on structure instructions' if instruction.output.nil?

          instruction.conflict = 'skip' unless instruction.conflict
          instruction.after_write = '' unless instruction.after_write

          L.kv 'conflict', instruction.conflict
          L.kv 'after_write', instruction.after_write

          if instruction.template_name.nil?
            template_file = nil
          else
            app_template_file = File.join(app_template_path, instruction.template_name)
            app_template_file = KDsl::Util.file.expand_path(app_template_file, project.config.base_app_template_path)

            common_template_file = File.join(common_template_path, instruction.template_name)
            common_template_file = KDsl::Util.file.expand_path(common_template_file, project.config.base_template_path)

            if File.exists?(app_template_file)
              template_file = app_template_file
            else
              template_file = common_template_file
            end

            L.kv 'app_template_file', KDsl::Util.data.console_file_hyperlink(app_template_file, app_template_file)
            L.kv 'app_template_file_exist', File.exist?(app_template_file)
          end

          if needs_template && !File.exist?(template_file)
            L.line
            L.kv 'template_file', KDsl::Util.data.console_file_hyperlink(template_file, template_file)
            L.kv 'template_file_exist', File.exist?(template_file)

            L.kv 'common_template_file', KDsl::Util.data.console_file_hyperlink(common_template_file, common_template_file)
            L.kv 'common_template_file_exist', File.exist?(common_template_file)
            L.line

            raise KDsl::Error, "Template not found. \n#{template_file}\n#{app_template_file}"
          end

          output_file = instruction.output
          output_file = output_file.gsub(/\$TEMPLATE_NAME\$/i, instruction.template_name) if instruction.template_name

          if opts[:output_file_tokens]
            opts[:output_file_tokens].keys.each do |key|
              value = opts[:output_file_tokens][key]
              output_file = output_file.gsub(/#{key}/, value)
            end
          end

          output_file = File.expand_path(output_file, opts[:microapp_settings].app_path) if opts[:microapp_settings]&.app_path.present?

          L.kv 'microapp.app_path', opts[:microapp_settings].app_path if opts[:microapp_settings]&.app_path.present?
          L.kv 'output_file', KDsl::Util.data.console_file_hyperlink(output_file, output_file)
          L.kv 'output_file_exist - before', File.exist?(output_file)
          L.kv 'command', instruction.command

          if instruction.command.casecmp('delete').zero?
            if File.exist?(output_file)
              File.delete(output_file) 

              L.kv 'remove file', output_file
            end

            next
          end

          if instruction.command.casecmp('mkdir').zero?
            FileUtils.mkdir_p(output_file)
            next
          end

          run_blueprint_instruction(instruction, template_file, output_file, **opts)

          raise KDsl::Error, 'Output file not found' if !File.exist?(output_file)

          execute_output_file output_file, :system  if instruction.command.casecmp('execute').zero?
          execute_output_file output_file, :fork    if instruction.command.casecmp('fork').zero?

          L.kv 'output_file_exist - after', File.exist?(output_file)
          L.line character: '-'

        end

      end

      def run_blueprint_instruction(instruction, template_file, output_file, **opts)
        FileUtils.mkdir_p(File.dirname(output_file))

        template = File.read(template_file)
        output = KDsl::TemplateRendering::TemplateHelper.process_template(template, opts)

        is_exist = File.exist?(output_file)
        is_write = false
        is_new   = false

        if is_exist
          if instruction.conflict.casecmp('skip').zero?
            L.kv 'ACTION WHEN FILE EXISTS', 'SKIPPING'
          end

          if instruction.conflict.casecmp('compare').zero?
            file = Tempfile.new
            file.write(output)
            file.close
            L.kv 'temp file', file.path
            is_write = true
            is_new = true

            if File.read(output_file) != output
              L.kv 'ACTION WHEN FILE EXISTS', 'COMPARE'
              system("code -d #{file.path} #{output_file}")
            else
              L.kv 'ACTION WHEN FILE EXISTS', 'COMPARE - SAME'
            end
          end

          if instruction.conflict.casecmp('overwrite').zero?
            is_write = true
            L.kv 'ACTION WHEN FILE EXISTS', 'OVER WRITING'
            File.write(output_file, output)
          end

        else
          File.write(output_file, output)
        end
        
        if instruction.after_write.casecmp('open').zero? ||
          (is_write && instruction.after_write.casecmp('open_if_write').zero?) ||
          (is_new && instruction.after_write.casecmp('open_if_new').zero?)
          system("code #{output_file}")
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
