# frozen_string_literal: true

require 'securerandom'

# DSL root factory methods
module KDsl
  class << self
    # I need to move the concept of document onto the project
    # IF KDsl.document is called then under the hood it should
    # instantiate a global project, but other projects are their
    # own namespaces that can be used to issolate for memory management
    def document(key = nil, type = nil, **options, &block)
      build_document(key, type, nil, **options, &block)
    end

    private

    def build_document(key, type, valid_types, **options, &block)
      # L.kv 'Build Document', k_key
      # L.kv 'K-Key', k_key
      # L.kv 'K-Type', type

      # I think it is ok to have NO key when you dopn't need to import, instead you can have a random guid

      # raise ::KDsl::Error, 'key must be a string or symbol' unless key.is_a?(String) || key.is_a?(Symbol)
      raise ::KDsl::Error, "Type is not supported: #{type}" if !valid_types.nil? && valid_types.include?(type)

      key ||= SecureRandom.uuid.to_s

      KDsl::Model::Document.new(key, type, **options, &block)
    end
  end
end
