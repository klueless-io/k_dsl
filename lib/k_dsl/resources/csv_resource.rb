# frozen_string_literal: true
require 'csv'

module KDsl
  module Resources
    # CSV Resource represents a CSV data structure in the project
    class CsvResource < Resource
      attr_reader :data

      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_CSV
      end

      def load
        @data = []
        CSV.parse(content, headers: true, header_converters: :symbol).each do |row|
          @data << OpenStruct.new(row.to_h)
        end
      end

      def debug
        tp data, data.first.to_h.keys
      end
    end
  end
end
