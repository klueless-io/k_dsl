# frozen_string_literal: true

require 'securerandom'

# REFACT: Look at these patterns: 
# https://github.com/guard/guard/blob/master/lib/guard.rb
# DSL root factory methods
module KDsl
  LOG_NONE = :none
  LOG_WARN = :warn
  LOG_INFO = :info

  class << self

    attr_accessor :status
    # Instance of the currently focused resource so that documents can attach themselves
    attr_accessor :target_resource

    # When creating a documents, we need a global container to hold them
    # Be careful when using this property as it is a Known anti-pattern
    # that is just trying to solve a specific problem.
    attr_accessor :transient_documents

    # Instance of a project manager that can manage multiple projects
    attr_reader :project_manager

    # REFACT: Need to research and implement the correct pattern for log levels
    attr_reader :log_level

    def setup(log_level: LOG_NONE, project_manager: Manage::ProjectManager.new)

      @log_level = log_level

      if log_info?
        L.heading 'Setup Klue DSL'
      end

      @status = :setup
      @resource = nil
      @project_manager = project_manager
    end

    def teardown
      @log_level = nil
      @resource = nil
      @project_manager = nil
    end

    # def add_project(name, )

    # I need to move the concept of document onto the project
    # IF KDsl.document is called then under the hood it should
    # instantiate a global project, but other project_manager have their
    # own namespaces that can be used to issolate for memory management
    def document(key = nil, type = nil, **options, &block)
      document = build_document(key, type, nil, **options, &block)

      if KDsl.target_resource
        KDsl.target_resource.add_document(document)
      end

      document
    end

    def log_warn?
      log_level == :warn
    end

    def log_info?
      log_level == :info
    end

    def log_none?
      log_level == :none
    end

    private

    def build_document(key, type, valid_types, **options, &block)
      # L.kv 'Build Document', k_key
      # L.kv 'K-Key', k_key
      # L.kv 'K-Type', type

      # I think it is ok to have NO key when you dopn't need to import, instead you can have a random guid

      # raise ::KDsl::Error, 'key must be a string or symbol' unless key.is_a?(String) || key.is_a?(Symbol)
      raise ::KDsl::Error, "Type is not supported: #{type}" if !valid_types.nil? && valid_types.include?(type)

      key ||= SecureRandom.uuid.to_s

      KDsl::Model::Document.new(key, type, **options, &block)
    end
  end
end
