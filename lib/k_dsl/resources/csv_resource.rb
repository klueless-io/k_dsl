# frozen_string_literal: true
require 'csv'

module KDsl
  module Resources
    # CSV Resource represents a CSV data structure in the project
    class CsvResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path)#, content: content)

        self.type = KDsl::Resources::Resource::TYPE_CSV
      end

      def register
        @document = add_document(new_document)
        project.add_resource_document(self, @document)
      end

      def load
        data = []
        CSV.parse(content, headers: true, header_converters: :symbol).each do |row|
          data << row.to_h
        end
        @document.set_data(data)
      end

      def debug
        tp @document.data, @document.data.first.to_h.keys
      end
    end
  end
end
