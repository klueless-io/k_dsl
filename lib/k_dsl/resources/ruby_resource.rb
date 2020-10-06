# frozen_string_literal: true

module KDsl
  module Resources
    # Ruby Resource represents a Ruby data structure in the project
    class RubyResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path)

        self.type = KDsl::Resources::Resource::TYPE_RUBY
      end

      def register
        KDsl.target_resource = self
        resource_document_count = project.resource_documents.length

        Object.class_eval content

        # DSL's will add new resource_documents
        if project.resource_documents.length > resource_document_count
          self.type = KDsl::Resources::Resource::TYPE_RUBY_DSL
        end
        puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        puts documents.length

      rescue => exeption
        # Report the error but still add the document so that you can see
        # it in the ResourceDocument list, it will be marked as Error
        @error = exeption

        # L.exception @error
      ensure
        KDsl.target_resource = nil

        # A regular ruby file would not add resource_documents
        # so create one manually
        if project.resource_documents.length === resource_document_count
          document = add_document(new_document)
          project.add_resource_document(self, document)
        end
      end

      def load
      #   Object.class_eval content
      # rescue => exeption
      #   # Report the error but still add the document so that you can see
      #   # it in the ResourceDocument list, it will be marked as Error
      #   @error = exeption

      #   L.exception @error
      # ensure
      #   add_new_document(data: @raw_data)
      end
    end
  end
end
