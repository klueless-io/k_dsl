module KDsl
  module Extensions
    module TemplateRenderable
      # Provides access to data via an import keyword
      #
      # Currently used an extension to document and accesses the linked 
      # resource.project to search for a suitable data attachment
      # def import(key, type = KDsl.config.default_document_type, namespace = nil)
      #   return warn('Import Skipped: Document not linked to a project') if !defined?(project) || project.nil?

      #   data = project.get_data(key, type, namespace)
      #   result = KDsl::Util.data.to_struct(data)

      #   result
      # end
    end
  end
end