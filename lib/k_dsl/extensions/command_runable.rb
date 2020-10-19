module KDsl
  module Extensions
    module CommandRunnable
      # Run command line program
      def run_command(command, command_creates_top_folder: false)
        return warn('Run command skipped: Document not linked to a project') if !defined?(project) || project.nil?

        L.kv 'Run command', command

        microapps = project.get_resource_documents_by_type(:microapp)

        raise KDsl::Error, 'Run command requires a microapp with target path' if microapps.empty?
        # Not sure if I will ever have multi-app projects, but if I do, then
        # a simple paramter to specify the key or namespace or pass in the microapp will surfice
        raise KDsl::Error, 'Run command currently supports single MicroApp projects only' if microapps.length > 1

        microapp_settings = microapps.first.document.data_struct.settings

        output_path = File.expand_path(microapp_settings.app_path)

        L.kv 'Target path', output_path

        # Some commans such as rails new will expect the output path
        # to not exist. These commands will take care of the path
        # creation themselves
        if command_creates_top_folder
          L.info 'This command will create the path on execution'
          # Strip the last path because so that command can take care of last path creation
          output_path = File.dirname(output_path)
        end

        # Deep path create if needed
        FileUtils.mkdir_p(output_path)

        build_command = "cd #{output_path} && #{command}"

        L.kv 'Run command in path', build_command

        system(build_command)
        # fork { exec(build_command) } 
      end
    end
  end
end