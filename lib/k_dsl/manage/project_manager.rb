# frozen_string_literal: true

# Provide access to the DSL Manager
module KDsl
  module Manage
    # Manager is used to manage active projects and memory management
    class ProjectManager
      attr_accessor :processor
      attr_accessor :projects
      attr_accessor :active_project

      def initialize
        @projects = []
        @active_project = nil
      end

      def add_project(project)
        raise KDsl::Error, 'Project is required' if project.nil?
        raise KDsl::Error, 'Project class is ivalid' unless project.is_a?(KDsl::Manage::Project)

        project.manager = self
        project.load_resources

        @projects |= [project]
     end

      def activate_project(project)
        add_project(project)

        @active_project = project
      end

      def deactivate_project
        @active_project = nil
      end

      # Register document with a project
      #
      # There is a tight coupling between new document instances and the active project
      # If I can find a way to decouple then I will, but for now, a new document will
      # call through to register_with_project and if there is no project then it will just
      # keep going
      def register_with_project(document)
        return :no_project if active_project.nil?

        # return :register
        # return :existing
      end

      def debug(format: :tabular, project_formats: [:resource])
        # tp projects

        if format == :tabular
          tp projects,
            :name,
            :managed?,
            { 'config.base_path'              => { width: 60, display_name: 'Base Path' } },
            { 'config.base_dsl_path'          => { width: 60, display_name: 'DSL Path' } },
            { 'config.base_data_path'         => { width: 60, display_name: 'Data_Path' } },
            { 'config.base_definition_path'   => { width: 60, display_name: 'Definition Path' } },
            { 'config.base_template_path'     => { width: 60, display_name: 'Template Path' } },
            { 'config.base_app_template_path' => { width: 60, display_name: 'AppTemplate Path' } }
        elsif
          L.kv '# of Projects', projects.length

          projects.each do |project|
            L.subheading(project.name)
            # Refactor (DslPath to ResourcePath)
            L.kv "Resource Path (DSL's, Data)", project.config.base_dsl_path
            L.kv 'Base Path', project.config.base_path
            # Refactor (DataPath to CachePath)
            L.kv 'Data Path (Cache)', project.config.base_data_path
            L.kv 'Definition Path', project.config.base_definition_path
            L.kv 'Template Path (Global)', project.config.base_template_path
            L.kv 'Template Path (Application)', project.config.base_app_template_path
            puts

            project_formats.each do |project_format|
              project.debug(format: project_format)
            end
          end
        end

      end
    end
  end
end
