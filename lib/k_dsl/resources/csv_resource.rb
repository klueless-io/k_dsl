# frozen_string_literal: true

module KDsl
  module Resources
    # CSV Resource represents a CSV data structure in the project
    class CsvResource < Resource
      def initialize(source:, file:, watch_path: nil, content: nil)
        super(source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_CSV
      end
    end
  end
end
