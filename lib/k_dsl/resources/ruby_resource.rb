# frozen_string_literal: true

module KDsl
  module Resources
    # Ruby Resource represents a Ruby data structure in the project
    class RubyResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_RUBY
      end

      def load
        Object.class_eval content
      rescue => exeption
        # Report the error but still add the document so that you can see
        # it in the ResourceDocument list, it will be marked as Error
        @error = exeption

        L.exception @error
      ensure
        add_new_document(data: @raw_data)
      end
    end
  end
end
