module KDsl
  module Extensions
    module CommandRunnable
      # Run command line program
      def run_command(command, command_creates_top_folder: false, microapp: nil)
        return warn('Run command skipped: Document not linked to a project') if !defined?(project) || project.nil?

        L.kv 'Run command', command

        if microapp.nil?
          microapps = project.get_resource_documents_by_type(:microapp)

          raise KDsl::Error, 'Run command requires a microapp with target path' if microapps.empty?
          # Not sure if I will ever have multi-app projects, but if I do, then
          # a simple parameter to specify the key or namespace or pass in the microapp will suffice
          raise KDsl::Error, 'Run command currently supports single MicroApp projects only' if microapps.length > 1

          microapp = microapps.first.document
        end

        microapp_settings = microapp.data_struct.settings

        output_path = File.expand_path(microapp_settings.app_path)

        L.kv 'Target path', output_path

        # Some commands such as rails new will expect the output path
        # to not exist. These commands will take care of the path
        # creation themselves
        if command_creates_top_folder
          L.info 'This command will create the path on execution'
          # Strip the last path because so that command can take care of last path creation
          output_path = File.dirname(output_path)
        end

        # Deep path create if needed
        FileUtils.mkdir_p(output_path)

        # asdf not working, why?
        # RBENV_VERSION
        build_command = "asdf current ruby && cd #{output_path} && #{command}"

        L.kv 'Run command in path', build_command

        system(build_command)
        # fork { exec(build_command) } 
      end
    end
  end
end