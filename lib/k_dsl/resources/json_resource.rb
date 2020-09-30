# frozen_string_literal: true

module KDsl
  module Resources
    # Json Resource represents a JSON data structure in the project
    class JsonResource < Resource
      def initialize(source:, file:, watch_path: nil, content: nil)
        super(source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_JSON
      end
    end
  end
end
