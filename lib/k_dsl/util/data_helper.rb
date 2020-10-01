# frozen_string_literal: true

module KDsl
  # File utilities
  module Util
    class << self
      attr_accessor :data
    end

    # Helper methods attached to the namespace for working with Data
    class DataHelper
      # Convert a hash into a deep OpenStruct or array an array
      # of objects into an array of OpenStruct 
      def self.to_struct(data)
        if data.is_a?(Hash)
          return OpenStruct.new(data.map { |k,v| [k, to_struct(v)] }.to_h )
  
        elsif data.is_a?(Array)
          return data.map { |o| to_struct(o) }
  
        else
          # Assumed to be a primititve value
          return data
        end
      end
    end
  end
end

KDsl::Util.data = KDsl::Util::DataHelper
