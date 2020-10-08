# frozen_string_literal: true
require 'csv'

module KDsl
  module Resources
    module Factories
      # Ruby RubyDocumentFactory can handle Ruby to produce a document
      # or KlueDSL content to produce one or more documents
      class RubyDocumentFactory < DocumentFactory
        def initialize(resource)
          super(resource, KDsl::Resources::Resource::TYPE_RUBY)
        end

        def create_documents
          KDsl.target_resource = self

          Object.class_eval content
  
          # Only DSL's will add new resource_documents
          if documents.length > 0
            resource.type = KDsl::Resources::Resource::TYPE_RUBY_DSL
          end
  
        rescue => exeption
          # Report the error but still add the document so that you can see
          # it in the ResourceDocument list, it will be marked as Error
          @error = exeption
  
          L.exception @error
        ensure
          KDsl.target_resource = nil
  
          # A regular ruby file would not add resource_documents
          # so create one manually
          add_document(new_document) if documents.length === 0
        end

        def parse_content
          documents.each(&:execute_block) if self.resource.type === KDsl::Resources::Resource::TYPE_RUBY_DSL
        rescue => exeption
          # Report the error but still add the document so that you can see
          # it in the ResourceDocument list, it will be marked as Error
          @error = exeption
  
          L.exception @error
        end
      end
    end
  end
end
