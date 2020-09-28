# frozen_string_literal: true

module KDsl
  module Manage
    # Resource represents a file in the project 
    #
    # Resources currently represent DSL's but I think I can have support for
    # other types of files such as (PORO, Ruby, JSON, CSV) and be able to use
    # them easily.
    class Resource

      TYPE_DSL = 'dsl'
      TYPE_CSV = 'csv'
      TYPE_JSON = 'json'
      TYPE_RUBY = 'ruby'

      # Type of resource
      attr_reader :type

      # Project configuration
      attr_reader :full_path

      def initialize(type, full_path)
        @type = type
        @full_path = full_path
      end
    end
  end
end
