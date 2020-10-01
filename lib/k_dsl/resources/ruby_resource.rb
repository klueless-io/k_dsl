# frozen_string_literal: true

module KDsl
  module Resources
    # Ruby Resource represents a Ruby data structure in the project
    class RubyResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path, content: content)

        self.type = KDsl::Resources::Resource::TYPE_RUBY
      end
    end
  end
end
