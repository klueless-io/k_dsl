# frozen_string_literal: true

module KDsl
  module Manage
    # Configuration data for the manager.
    #
    # You may want to have multiple managers and so it is useful to
    # store the configuation in an object that can be passed. 
    class ProjectConfig
      # Base path for project resources (defaults to current working directory)
      # Usually set to centralized path that is reused across projects
      attr_accessor :base_path

      # Base path for your resources (DSL's & Data)
      # defaults to current working directory
      attr_accessor :base_resource_path

      # Bases path where cache data is written to
      attr_writer :base_cache_path

      # Path to Templated DSLs. These are the basis for new DSL's
      # Refactor (DefinitionPath to DslTemplatePath)
      attr_writer :base_definition_path

      # Default path for view templates
      attr_writer :base_template_path

      # Application specific override for templates (need to find a hidden location for this)
      attr_writer :base_app_template_path

      def initialize(&block)
        @base_path = Dir.getwd
        @base_resource_path = Dir.getwd

        begin
          instance_eval(&block) if block_given?
        rescue => exception
          L.heading "Invalid code block in project config"
          L.exception exception
          raise
        end
        # yield self if block_given?
      end

      def to_h
        {
          base_path: base_path,
          base_resource_path: base_resource_path,
          base_cache_path: base_cache_path,
          base_definition_path: base_definition_path,
          base_template_path: base_template_path,
          base_app_template_path: base_app_template_path
        }
      end

      def base_cache_path
        if @base_cache_path.nil?
          File.join(base_path, '.cache')
        else
          @base_cache_path
        end
      end

      def base_definition_path
        if @base_definition_path.nil?
          File.join(base_path, '.definition')
        else
          @base_definition_path
        end
      end

      def base_template_path
        if @base_template_path.nil?
          File.join(base_path, '.template')
        else
          @base_template_path
        end
      end

      def base_app_template_path
        if @base_app_template_path.nil?
          File.join(base_path, '.app_template')
        else
          @base_app_template_path
        end
      end
    end
  end
end
