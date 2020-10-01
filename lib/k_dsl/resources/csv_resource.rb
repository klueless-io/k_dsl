# frozen_string_literal: true
require 'csv'

module KDsl
  module Resources
    # CSV Resource represents a CSV data structure in the project
    class CsvResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_CSV
      end

      def load
        @raw_data = []
        CSV.parse(content, headers: true, header_converters: :symbol).each do |row|
          @raw_data << row.to_h# OpenStruct.new(row.to_h)
        end
        @data = KDsl::Util.data.to_struct(@raw_data)
      end

      def debug
        tp data, data.first.to_h.keys
      end
    end
  end
end
