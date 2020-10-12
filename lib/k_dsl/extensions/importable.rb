module KDsl
  module Extensions
    module Importable
      # Provides access to data via an import keyword
      #
      # Currently used an extension to document and accesses the linked 
      # resource.project to search for a suitable data attachment
      def import(key, type = KDsl.config.default_document_type, namespace = nil)
        proj = resource&.project
        return import_warn('Import Skipped: Document not linked to a project') unless proj

        data = proj.get_data(key, type, namespace)
        result = KDsl::Util.data.to_struct(data)

        result
      end

      private

      def import_warn(message)
        L.warn message
        nil
      end
    end
  end
end