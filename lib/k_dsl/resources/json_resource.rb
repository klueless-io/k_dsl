# frozen_string_literal: true

module KDsl
  module Resources
    # Json Resource represents a JSON data structure in the project
    class JsonResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path)#, content: content)

        self.type = KDsl::Resources::Resource::TYPE_JSON
      end

      def register
        @document = add_document(new_document)
      end

      # Where is register in all this?
      def load
        data = JSON.parse(content)
        @document.set_data(data)
        # @data = KDsl::Util.data.to_struct(@raw_data)
      end

      def debug
        L.ostruct(KDsl::Util.data.to_struct(@document.data))
      end
    end
  end
end
