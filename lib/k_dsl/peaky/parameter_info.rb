# frozen_string_literal: true

# require 'k_dsl/peaky/parameter_info'

module KDsl
  module Peaky
    # Parameter Info
    class ParameterInfo
      attr_accessor :name                # name of the parameter
      attr_accessor :type                # type of the parameter
      attr_accessor :signature_format    # ruby code format when used in a signature
      attr_accessor :minimal_call_format # minimal required usage in a call to the method with this paramater

      def initialize(ruby_method_param)
        map(ruby_method_param)
      end

      def self.build(ruby_method_parameters)
        parameters.map do |ruby_method_param|
          ParameterInfo.new(ruby_method_param)
        end
      end

      private

      # Convert the limited information provided by ruby method.parameters
      # to a richer structure.
      def map(ruby_method_param)
        self.name = ruby_method_param.length > 1 ? ruby_method_param[1] : ''

        # name                - name of the parameter
        # type                - type of the parameter
        # signature_format    - ruby code format when used in a signature
        # minimal_call_format -

        case ruby_method_param[0]
        when :req
          self.type = :param_required
          self.signature_format = "#{name}"
          self.minimal_call_format = "'#{name}'"
        when :opt
          self.type = :param_optional
          self.signature_format = "#{name} = nil"
          self.minimal_call_format= ""
        when :rest
          self.type = :splat
          self.signature_format = "*#{name}"
          self.minimal_call_format = ""
        when :keyreq
          self.type = :key_required
          self.signature_format = "#{name}:"
          self.minimal_call_format = "#{name}: '#{name}'"
        when :key
          self.type = :key_optional
          self.signature_format = "#{name}: nil"
          self.minimal_call_format = ""
        when :keyrest
          self.type = :double_splat
          self.signature_format = "**#{name}"
          self.minimal_call_format = ""
        when :block
          self.type = :block
          self.signature_format = "&#{name}"   
          self.minimal_call_format = ""
        else
          raise 'unknown type'
        end
      end
    end
  end
end
