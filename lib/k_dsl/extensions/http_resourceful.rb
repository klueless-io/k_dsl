# require 'net/http'

module KDsl
  module Extensions
    module HttpResourceful
      # Run command line program
      def http_resource_to_file(
        url: nil,
        target_folder: nil,
        target_file: nil,
        microapp: nil)
        
        return warn('HTTP resource to file skipped: Document not linked to a project') if !defined?(project) || project.nil?
        return warn('HTTP resource is required') if url.nil?
        return warn('Target file is required') if target_file.nil?

        L.kv 'Read resource', url

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
        output_path = File.join(output_path, target_folder) if target_folder.present?
        output_file = File.join(output_path, target_file)

        L.kv 'Target file', output_file

        # Deep path create if needed
        FileUtils.mkdir_p(output_path)

        response = fetch(url)

        if response.code == '200'
          File.write(output_file, response.body)
        else
          L.error response.code
        end

        # http_resource_to_file(uri: 'https://raw.githubusercontent.com/klueless-html-samples/L04TranspilerBabel/master/src/test.js',
        #   target_folder: 'src',
        #   target_file: 'test.js')
      end

      def fetch(url, limit = 10)
        # You should choose a better exception.
        raise ArgumentError, 'too many HTTP redirects' if limit == 0
      
        response = Net::HTTP.get_response(URI(url))
      
        case response
        when Net::HTTPSuccess then
          response
        when Net::HTTPRedirection then
          # UNTESTED
          location = response['location']
          warn "redirected to #{location}"
          fetch(location, limit - 1)
        else
          response.value
        end
      end
    end
  end
end