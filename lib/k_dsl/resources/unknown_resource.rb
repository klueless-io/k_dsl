# frozen_string_literal: true

module KDsl
  module Resources
    # Unknown Resource represents a resource with unknown content
    #
    # Alter detect_type if you need specific representation of this content
    class UnknownResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path)#, content: content)

        self.type = KDsl::Resources::Resource::TYPE_UNKNOWN
      end

      def register
        @document = add_document(new_document)
        project.add_resource_document(self, @document)
      end

      def load
      end

      def debug
        L.warn 'unknown document'
      end
    end
  end
end
