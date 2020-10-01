# frozen_string_literal: true

module KDsl
  module Resources
    # Json Resource represents a JSON data structure in the project
    class JsonResource < Resource
      attr_reader :data

      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_JSON
      end

      def load
        @data = KDsl::Util.data.to_struct(JSON.parse(content))
      end

      def debug
        L.json(KDsl::Util.data.struct_to_hash(data))
        L.ostruct(data)
      end
    end
  end
end
