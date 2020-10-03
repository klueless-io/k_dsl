# frozen_string_literal: true

module KDsl
  module Resources
    # Json Resource represents a JSON data structure in the project
    class JsonResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_JSON
      end

      # Where is register in all this?
      def load
        @raw_data = JSON.parse(content)
        add_document(filename, type, '', @raw_data)
        # @data = KDsl::Util.data.to_struct(@raw_data)
      end

      def debug
        L.ostruct(KDsl::Util.data.to_struct(documents.first.data))
      end
    end
  end
end
