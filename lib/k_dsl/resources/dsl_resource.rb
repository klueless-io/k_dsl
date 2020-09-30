# frozen_string_literal: true

module KDsl
  module Resources
    # Dsl Resource represents a Dsl data structure in the project
    class DslResource < Resource
      def initialize(source:, file:, watch_path: nil, content: nil)
        super(source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_RUBY_DSL
      end
    end
  end
end
