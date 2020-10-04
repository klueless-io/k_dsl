# frozen_string_literal: true

module KDsl
  module Resources
    # ResourceDocument represents the (1-M) link between a resource and a document
    class ResourceDocument
      extend Forwardable

      attr_reader :status
      attr_reader :resource
      attr_reader :document

      def_delegator :@resource, :raw_data
      def_delegator :@resource, :data
      def_delegator :@resource, :error
      def_delegator :@resource, :project
      def_delegator :@resource, :source
      def_delegator :@resource, :type, :resource_type
      def_delegator :@resource, :file
      def_delegator :@resource, :watch_path
      def_delegator :@resource, :content
      def_delegator :@resource, :relative_watch_path
      def_delegator :@resource, :filename
      def_delegator :@resource, :base_resource_path
      def_delegator :@resource, :base_resource_path_expanded

      def_delegator :document, :key
      def_delegator :document, :type
      def_delegator :document, :namespace
      def_delegator :document, :options

      def initialize(resource, document)
        @status = :registered
        @resource = resource
        @document = document
      end
    end
  end
end
