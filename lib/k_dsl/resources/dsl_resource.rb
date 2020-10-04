# frozen_string_literal: true

module KDsl
  module Resources
    # Dsl Resource represents a Dsl data structure in the project
    class DslResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_RUBY_DSL
      end

      def load
        KDsl.resource = self
        Object.class_eval content
      rescue => exeption
        # Report the error but still add the document so that you can see
        # it in the ResourceDocument list, it will be marked as Error
        @error = exeption
  
        L.exception @error
      ensure
        KDsl.resource = nil
      end
    end
  end
end
