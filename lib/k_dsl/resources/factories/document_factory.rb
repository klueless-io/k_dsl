# frozen_string_literal: true
require 'csv'

module KDsl
  module Resources
    module Factories
      # Base factory for creationg resource_documents
      # Tightly coupled to the resource using polymorphic composition
      # Something WRONG, should this be a module include instead of a Forwardable Class?
      class DocumentFactory
        extend Forwardable

        # attr_reader :type

        attr_reader :resource

        def_delegator :resource, :project
        def_delegator :resource, :content
        def_delegator :resource, :documents
        def_delegator :resource, :new_document
        def_delegator :resource, :add_document
        def_delegator :resource, :infer_document_key
        def_delegator :resource, :infer_document_type
        def_delegator :resource, :infer_document_namespace

        def initialize(resource, type)
          @resource = resource
          resource.type = type
        end
      end
    end
  end
end
