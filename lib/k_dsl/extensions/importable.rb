module KDsl
  module Extensions
    module Importable
      # Provides access to data via an import keyword
      #
      # Currently used an extension to document and accesses the linked 
      # resource.project to search for a suitable data attachment
      def import(key, type = KDsl.config.default_document_type, namespace = nil)
        project = resource&.project

        if project
          # REFACT: Must support document not found error handling
          data = project.get_data(key, type, namespace)
          result = KDsl::Util.data.to_struct(data)

          result
        else
          L.warn 'Import Skipped: Document is not linked to a project'
        end
      end
    end
  end
end