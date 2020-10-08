# frozen_string_literal: true

module KDsl
  module ResourceDocuments
    # ResourceDocument represents the (1-M) link between a resource and a document
    class ResourceDocument
      extend Forwardable

      attr_accessor :status
      attr_reader :resource
      attr_reader :document

      def_delegator :resource, :load
      def_delegator :resource, :load

      def_delegator :resource, :error
      def_delegator :resource, :project
      def_delegator :resource, :source
      def_delegator :resource, :type, :resource_type
      def_delegator :resource, :file
      def_delegator :resource, :watch_path
      def_delegator :resource, :content
      def_delegator :resource, :relative_watch_path
      def_delegator :resource, :filename
      def_delegator :resource, :base_resource_path
      def_delegator :resource, :base_resource_path_expanded

      def_delegator :document, :unique_key
      def_delegator :document, :key
      def_delegator :document, :type
      def_delegator :document, :namespace
      def_delegator :document, :options

      def_delegator :document, :data

      def initialize(resource, document)
        @status = :initialized
        @resource = resource
        @document = document
      end
    end
  end
end
