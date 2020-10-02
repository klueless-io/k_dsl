# frozen_string_literal: true

module KDsl
  module Artifacts
    # Artifact represents some type of data or DSL structure
    class Artifact

      OTHER_TYPES = %i[cmd].freeze
      MICROAPP_TYPES = %i[microapp domain blueprint structure].freeze
      DOMAIN_TYPES = %i[entity value_object app_settings command].freeze
      TYPES = MICROAPP_TYPES | DOMAIN_TYPES | OTHER_TYPES

      STATE_REGISTERED = 'registered'
      STATE_LOADED = 'loaded'

      # Resource that created this artifact
      attr_reader :resource

      # Namespace (optional), this allows the seperation of artifacts same name but different contexts
      attr_reader :namespace

      # Key provides a lookup name for this entity
      attr_reader :key

      # Type of artifact
      attr_reader :type

      # State of the artifact, registered, loaded
      attr_reader :state

      def initialize(resource, key, type: DOMAIN_TYPES.first, namespace: nil)
        raise KDsl::Error, 'Resource is required' if resource.nil?
        raise KDsl::Error, "Resource is must be a 'KDsl::Resources::Resource'" unless resource.is_a?(KDsl::Resources::Resource)
        raise KDsl::Error, 'Key is required' if key.nil?

        @resource = resource
        @namespace = namespace
        @key = key.to_s
        @type = type
        @state = STATE_LOADED
      end
    end
  end
end
