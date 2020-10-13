# frozen_string_literal: true

module KDsl
  module Model
    class BlueprintDocument < Document
      def instructions(name = :instructions, &block)
        table(name, &block)
      end
    end
  end
end
