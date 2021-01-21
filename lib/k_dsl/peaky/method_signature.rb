# frozen_string_literal: true

# require 'k_dsl/peaky/method_signature'

module KDsl
  module Peaky
    # Method Signature
    class MethodSignature
      attr_reader :instance
      attr_reader :instance_name
      attr_reader :method_definitions
  
      def initialize(instance, instance_name: nil )
        @instance = instance
        @instance_name = instance_name ||= instance.class.to_s.parameterize.underscore
      end

      # instance_methods = instance.class.instance_methods(false).sort
      # @method_definitions = build_method_definitions(instance, instance_methods)

      def build_method_definitions(instance, method_names)
        method_names.map do |method_name|
          meth = instance.method(method_name)
  
          instance_method = OpenStruct.new(
            klass: meth.owner,
            receiver: meth.receiver,
            name: method_name,
            arity: meth.arity,
            super: meth.super_method,
            original_parameters: meth.parameters,
            parameters: parameter_info(meth.parameters),
            location: meth.source_location.join(':')
          )
          instance_method.formatted_parameters = instance_method.parameters.map { |p| p[:signature_format] }.join(', ')
          instance_method.minimal_call_parameters = instance_method.parameters.map { |p| p[:minimal_call_format] }.reject(&:blank?).join(', ')
          instance_method.signature = build_signature(instance_method.name, instance_method.formatted_parameters)
          instance_method.minimum_call_signature = build_minimal_call_signature(instance_method.name, instance_method.minimal_call_parameters)
          instance_method
        end
      end
  
      # Convert the limited information provided by ruby method.parameters
      # to a richer structure.
      def parameter_info(params)
        parameter_info = params.map do |p|
          name = p.length > 1 ? p[1] : ''

          # name                - name of the parameter
          # type                - type of the parameter
          # signature_format    - ruby code format when used in a signature
          # minimal_call_format - 
  
          case p[0]
          when :req
            { name: name, type: :param_required, signature_format: "#{name}"      , minimal_call_format: "'#{name}'" }
          when :opt
            { name: name, type: :param_optional, signature_format: "#{name} = nil", minimal_call_format: "" }
          when :rest
            { name: name, type: :splat         , signature_format: "*#{name}"     , minimal_call_format: "" }
          when :keyreq
            { name: name, type: :key_required  , signature_format: "#{name}:"     , minimal_call_format: "#{name}: '#{name}'" }
          when :key
            { name: name, type: :key_optional  , signature_format: "#{name}: nil" , minimal_call_format: "" }
          when :keyrest
            { name: name, type: :double_splat  , signature_format: "**#{name}"    , minimal_call_format: "" }
          when :block
            { name: name, type: :block         , signature_format: "&#{name}"     , minimal_call_format: "" }
          else
            raise 'unknown type'
          end
        end
      end
  
      # Build simple method signature that matches the parameters
      def build_signature(name, formatted_parameters)
        params = formatted_parameters.length == 0 ? '' : "(#{formatted_parameters})"
        lhs = "def #{name}#{params};"
        rhs = 'end'
        "#{lhs.ljust(46)}#{rhs}"
      end
  
      # Build a minimal method call, that means the method will run with the simplest 
      # number of parameters possible
      def build_minimal_call_signature(name, minimal_call_parameters)
        params = minimal_call_parameters.length == 0 ? '' : "(#{minimal_call_parameters})"
        "#{@instance_name}.#{name}#{params}"
      end
      
      # Helpers for printing
      def print(*formats)
        formats ||= %i[signature]
  
        formats.each do |format|
          case format
          when :signature
            puts '-' * 70
            puts "Generate method signatures for class '#{@instance.class}'"
            puts '-' * 70
            self.method_definitions.each { |md| puts md.signature }
            puts '-' * 70
  
          when :minimal_call
            puts '-' * 70
            puts "Generate minimalistic method calls for class '#{@instance.class}'"
            puts '-' * 70
            puts "#{@instance_name} = #{@instance.class}.new"
            puts ''
            self.method_definitions.each { |md| puts md.minimum_call_signature }
            puts '-' * 70
          end
        end
      end
  
      # Helpers for printing using table_print GEM
      def print1
        tp self.method_definitions,
          :klass,
          :name,
          :arity,
          'parameters.name',
          'parameters.type',
          'parameters.format'
      end
  
      # Helpers for printing using table_print GEM
      def print2
        tp self.method_definitions,
          :klass,
          :name,
          :arity,
          { formatted_parameters: { width: 140 } },
          { signature: { width: 140 } }
      end
    end
  end
end
