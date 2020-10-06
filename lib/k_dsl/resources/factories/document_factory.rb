# frozen_string_literal: true
require 'csv'

module KDsl
  module Resources
    module Factories
      class ResourceFactory
        attr_reader :resource
        attr_reader :type

        def initialize(resource, type)
          @resource = resource
          @type = type
        end
      end
    end
  end
end
