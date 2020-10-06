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

        Object.class_eval content

        # Only DSL's will add new resource_documents
        if documents.length > 0
          self.type = KDsl::Resources::Resource::TYPE_RUBY_DSL
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

      def load
        documents.each(&:execute_block) if self.type === KDsl::Resources::Resource::TYPE_RUBY_DSL
      rescue => exeption
        # Report the error but still add the document so that you can see
        # it in the ResourceDocument list, it will be marked as Error
        @error = exeption

        L.exception @error
    end
    end
  end
end
