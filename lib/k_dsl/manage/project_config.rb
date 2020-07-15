# frozen_string_literal: true

module KDsl
  module Manage
    # Configuration data for the manager.
    #
    # You may want to have multiple managers and so it is useful to
    # store the configuation in an object that can be passed. 
    class ProjectConfig
      # Base path for your DSL's (defaults to current working directory)
      attr_accessor :base_dsl_path

      # Bases path where data is written to
      attr_writer :base_data_path

      # Path to Templated DSLs. These are the basis for new DSL's
      attr_writer :base_definition_path

      # Default path for view templates
      attr_writer :base_template_path

      # Application specific override for templates (need to find a hidden location for this)
      attr_writer :base_app_template_path

      def initialize
        @base_dsl_path = Dir.getwd

        yield self if block_given?
      end

      def to_h
        {
          base_dsl_path: base_dsl_path,
          base_data_path: base_data_path,
          base_definition_path: base_definition_path,
          base_template_path: base_template_path,
          base_app_template_path: base_app_template_path
        }
      end

      def base_data_path
        if @base_data_path.nil?
          File.join(base_dsl_path, '.data')
        else
          @base_data_path
        end
      end

      def base_definition_path
        if @base_definition_path.nil?
          File.join(base_dsl_path, '.definition')
        else
          @base_definition_path
        end
      end

      def base_template_path
        if @base_template_path.nil?
          File.join(base_dsl_path, '.template')
        else
          @base_template_path
        end
      end

      def base_app_template_path
        if @base_app_template_path.nil?
          File.join(base_dsl_path, '.app_template')
        else
          @base_app_template_path
        end
      end
    end
  end
end
