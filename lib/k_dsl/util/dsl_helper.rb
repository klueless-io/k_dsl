# frozen_string_literal: true

module KDsl
  # DSL utilities
  module Util
    class << self
      attr_accessor :dsl
    end

    # Helper methods attached to the namespace for working with DSL's
    class DslHelper
      class << self
        def build_unique_key(key, type = nil, namespace = nil)
          raise KDsl::Error, 'key is required when generating unique key' if key.nil? || key.empty?

          type ||= KDsl.config.default_document_type

          namespace.nil? || namespace.empty? ? "#{key}_#{type}" : "#{namespace}_#{key}_#{type}"
        end
      end
    end
  end
end

KDsl::Util.dsl = KDsl::Util::DslHelper
