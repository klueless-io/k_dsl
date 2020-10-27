module KDsl
  module Extensions
    module Importable
      # Provides access to data via an import keyword
      #
      # Currently used an extension to document and accesses the linked 
      # resource.project to search for a suitable data attachment
      def import(key, type = KDsl.config.default_document_type, namespace = nil)
        return warn('Import Skipped: Document not linked to a project') if !defined?(project) || project.nil?

        resource_document = project.get_resource_document(key, type, namespace)

        raise "Could not import DSL: #{KDsl::Util.dsl.build_unique_key(key, type, namespace)}" if resource_document.nil?

        if !resource_document.document.loaded?
          resource_document.document.execute_block
        end

        data = resource_document.document.data
        result = KDsl::Util.data.to_struct(data)

        if ['template_options_entity', 'code_spec_pair_blueprint'].include? resource_document.unique_key
          L.error 'xxxxxxxxxxxxxxxxxxxxxxxxx'
          resource_document.debug
          L.error 'xxxxxxxxxxxxxxxxxxxxxxxxx'
        end

        if resource_document.respond_to?(:on_import)
          L.warn 'LETS be RESPONDIBLE'

          resource_document.on_import(result)
        end

        result
      end
    end
  end
end