# frozen_string_literal: true

# Provide access to the DSL Manager
module KDsl
  module Manage
    # Manager is used to manage active projects and memory management
    class ProjectManager
      attr_accessor :projects
      attr_accessor :active_project

      def initialize
        @projects = []
        @active_project = nil
      end

      def activate_project(project)
        raise KDsl::Error, 'Project is required' if project.nil?

        @projects |= [project]
        @active_project = project
      end

      def deactivate_project
        @active_project = nil
      end

      # Register document with a project
      #
      # There is a tight coupling between new document instances and the active project
      # If I can find a way to decouple then I will, but for now, a new document will
      # call through to register_with_project and if there is not project then it will just
      # keep going
      def register_with_project(document)
        return :no_project if active_project.nil?

        # return :register
        # return :existing
      end
    end
  end
end
