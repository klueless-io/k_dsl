# frozen_string_literal: true

module KDsl
  module Resources
    # Unknown Resource represents a resource with unknown content
    #
    # Alter detect_type if you need specific representation of this content
    class UnknownResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_UNKNOWN
      end
    end
  end
end
