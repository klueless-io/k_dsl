# frozen_string_literal: true

module KDsl
  module Manage
    # Project all the file paths and DSL documents that are avialable.
    #
    # It is assumed there is a root path that DSL's live under,
    # but you can register from outside this root path using
    # fully qualified file names.
    #
    # Different concepts that relate to register
    # 1. Registrations is used to pre-register DSL's and generally represents
    #    the available DSL's that you can interact with.
    # 2. Import happens after registrationg and represents the instantiation
    #    of a DSL for use either on it's own or by other DSL's
    class Project
      # Project name
      attr_reader :name

      # Project configuration
      attr_reader :config

      # Reference to manager that manages all projects
      attr_accessor :manager

      # Reference to processor that processes files, e.g. DSL's
      attr_accessor :processor

      # List of DSL's instances
      attr_reader :dsls

      # List of paths containing DSL's
      # WARN  : This list does not keep the wild card pattern.
      #         e.g. /*.rb or /**/*.rb 
      #         It does expand the ** for situations where there
      #         is a file in that child path, but because it is not
      #         being stored we have some edge case failures during
      #         file add, update and delete
      # REFACT: This pattern should be stored so that it can be 
      #         checked when a file is add, updated, deleted and that
      #         file fits the pattern
      attr_reader :watch_paths

      # List of resource files that are visible to this project
      # REFACT: May be available from dsls, need to check
      # REFACT: Also there is no guarantee that the file is actually a DSL
      # RENAME: registered_resources (as they may not be DSL's)
      attr_reader :registered_resources

      # There is currently a tight cupling between is boolean and DSL's so that they know whether they are being refrenced for registration or importation
      # The difference is that importation will execute their interal code block while registration will not.
      # attr_reader :current_state
      # attr_reader :current_register_file

      # what file is currently being processed
      # attr_reader :current_processing_file

      def initialize(name, config = nil, &block)
        raise KDsl::Error, 'Provide a project name' unless name.is_a?(String) || name.is_a?(Symbol)

        @name = name
        @config = config || KDsl::Manage::ProjectConfig.new

        # REFACT: Wrap DSL's up into it's own class
        @dsls = {}
        @watch_paths = []
        @registered_resources = []

        begin
          instance_eval(&block) if block_given?
        rescue => exception
          L.heading "Invalid code block in project during initialization: #{name}"
          L.exception exception
          raise
        end

        # @current_state = :dynamic
        # @current_register_file = nil
      end

      def dsl_exist?(key, type = nil, namespace = nil)
        dsl = get_dsl(key, type, namespace)

        !dsl.nil?
      end

      def get_dsl(key, type = nil, namespace = nil)
        unique_key = KDsl::Util.dsl.build_unique_key(key, type, namespace)

        @dsls[unique_key]
      end

      # rubocop:disable Metrics/AbcSize
      def get_dsls_by_type(type = nil, namespace = nil)
        type ||= KDsl.config.default_document_type
        type = type.to_s
        namespace = namespace.to_s

        if namespace.nil? || namespace.empty?
          @dsls.values.select { |dsl| dsl[:type] == type.to_s }
        else
          @dsls.values.select { |dsl| dsl[:namespace] == namespace && dsl[:type] == type }
        end
      end
      # rubocop:enable Metrics/AbcSize

      # Register any files found in the absolute path or path relative to base_dsl_path
      #
      # Files are generally DSL's but support for other types (PORO, Ruby, JSON, CSV) will come
      def watch_path(path, ignore: nil)
        # puts  "watch path: #{path} "
        path = KDsl::Util.file.expand_path(path, config.base_dsl_path)

        Dir[path].sort.each do |file|
          watch_path = File.dirname(file)
          @watch_paths << watch_path unless @watch_paths.include? watch_path

          register_file_resource(file, watch_path: watch_path, path_expansion: false, ignore: ignore)
        end
      end

      # Work through each resource and load into memory so that we can access
      # the data in the resource
      def load_resources
        @registered_resources.each do |resource|
          resource.load
        end
      end

      # Register a resource in @reegeistered_resources from a file
      #
      # Primary resource that is registered will be a Klue DSL
      # Other resources that can be supported include
      # data files:
      #   CSV, JSON, YAML
      # ruby code
      #   Classes etc..
      def register_file_resource(file, watch_path: nil, path_expansion: true, ignore: nil)
        file = KDsl::Util.file.expand_path(file, config.base_dsl_path) if path_expansion

        return if ignore && file.match(ignore)
        return unless File.exist?(file)

        resource = KDsl::Resources::Resource.instance(
          project: self,
          file: file,
          watch_path: watch_path,
          source: KDsl::Resources::Resource::SOURCE_FILE)

        @registered_resources << resource unless @registered_resources.include? resource
      end

      def register_dsl(document)
        ukey = document.unique_key

        # REFACT: I need a guard to check on duplicate keys from different files
        return dsls[ukey] if dsls.key?(ukey)

        dsls[ukey] = {
          key: document.key.to_s,
          type: document.type.to_s,
          namespace: document.namespace.to_s,
          state: :registered,
          document: document
        }
      end

      # REACT: This method may not belong to project, it should be in it's own class
      def process_code(code, source_file = nil)
        guard_source_file(source_file)

        # L.kv 'process_code.file', file
        current_processing_file = source_file

        # print_main_properties
        # L.block code
        begin
          # Anything can potentially run, but generally one of the Klue.factory_methods
          # should run such as Klue.structure or Klue.artifact
          # When they run they can figure out for themselves what file called them by
          # storing @current_processing_file into a document propert
          # rubocop:disable Security/Eval

          # This code is not thread safe
          # SET self as the current project so that we can register within in the document

          eval(code)

          # Clear self as the current project
          # rubocop:enable Security/Eval
        rescue KDsl::Error => e
          puts "__FILE__: #{__FILE__}"
          puts "__LINE__: #{__LINE__}"
          L.error e.message
          raise
        rescue StandardError => e
          L.kv '@current_processing_file', @current_processing_file
          L.kv '@current_state', current_state
          L.kv '@current_register_file', @current_register_file

          L.exception(e)
        end

        @current_processing_file = nil
      end

      def managed?
        !self.manager.nil?
      end

      def debug(format: :resource)
        if format == :resource
          tp registered_resources,
          # :state,
          { source: { } },
          { type: { display_name: 'R-Type' } },
          { raw_data: { width: 40, display_name: 'Data' } },
          { error: { width: 40, display_method: lambda { |r| r.error && r.error.message ? 'Error' : '' } } },
          { base_resource_path: { width: 100, display_name: 'Resource Path' } },
          { relative_watch_path: { width: 100, display_name: 'Watch Path' } },
          # { :watch_path => { width: 100, display_name: 'Watch Path' } },
          # { :file => { width: 100, display_name: 'File' } },
          # { :filename => { width: 100, display_name: 'Filename' } },
          { filename: { width: 150, display_method: lambda { |r| "\u001b]8;;file://#{r.file}\u0007#{r.filename}\u001b]8;;\u0007" } } }
        elsif format == :resource_document
          resource_documents = registered_resources.flat_map { |r| r.documents.map { |d| KDsl::Resources::ResourceDocument.new(r, d) } }

          tp resource_documents,
            { namespace: { width: 20, display_name: 'Namespace' } },
            { key: { width: 20, display_name: 'Key' } },
            { type: { width: 20, display_name: 'Type' } },
            # :state,
            { source: { } },
            { resource_type: { display_name: 'R-Type' } },
            { raw_data: { width: 40, display_name: 'Data' } },
            { error: { width: 40, display_method: lambda { |r| r.error && r.error.message ? 'Error' : '' } } },
            { base_resource_path: { width: 100, display_name: 'Resource Path' } },
            { relative_watch_path: { width: 100, display_name: 'Watch Path' } },
            # { :watch_path => { width: 100, display_name: 'Watch Path' } },
            # { :file => { width: 100, display_name: 'File' } },
            # { :filename => { width: 100, display_name: 'Filename' } },
            { filename: { width: 150, display_method: lambda { |r| "\u001b]8;;file://#{r.file}\u0007#{r.filename}\u001b]8;;\u0007" } } }
        else
          # projects.each do |project|
          #   L.subheading(project.name)
          #   L.kv 'Base Path', project.config.base_path
          #   L.kv 'DSL Path', project.config.base_dsl_path
          #   L.kv 'Data_Path', project.config.base_data_path
          #   L.kv 'Definition Path', project.config.base_definition_path
          #   L.kv 'Template Path', project.config.base_template_path
          #   L.kv 'AppTemplate Path', project.config.base_app_template_path
          # end
        end

      end

      # def self.create(base_dsl_path, base_data_path: nil, base_definition_path: nil, base_template_path: nil, &block)
      #   # L.kv 'create1', '@@instance is Present'  if @@instance.present?
      #   # L.kv 'create1', '@@instance is Nil'      if @@instance.nil?

      #   if @@instance.nil?
      #     # L.heading 'in create'
      #     # L.kv 'dsl', base_dsl_path;
      #     # L.kv 'data', base_data_path

      #     @@instance = new(base_dsl_path, base_data_path, base_definition_path, base_template_path)
      #     @@instance.instance_eval(&block) if block_given?

      #   end

      #   @@instance
      # end

      # private_class_method :new


      # def process_code(caller, code, source_file = nil)
      #   # L.kv 'process_code.caller', caller
      #   # L.kv 'process_code.source_file', source_file
        
      #   @current_processing_file = source_file

      #   if source_file.blank?
      #     # L.info 'no source files'
      #   end

      #   if source_file.present? && !source_file.starts_with?(*@watch_paths)
      #     L.kv 'source_file', source_file
      #     raise Klue::Dsl::DslError, 'source file skipped, file is not on a registered path'
      #   end

      #   print_main_properties
      #   # L.block code

      #   begin
      #     # Anything can potentially run, but generally one of the Klue.factory_methods 
      #     # should run such as Klue.structure or Klue.artifact
      #     # When they run they can figure out for themselves what file called them by 
      #     # storing @current_processing_file into a document property
      #     eval(code)
      #   rescue Klue::Dsl::DslError => exception
      #     # puts "__FILE__: #{__FILE__}"
      #     # puts "__LINE__: #{__LINE__}"
      #     L.error exception.message
      #     raise

      #   rescue => exception
      #     L.kv '@current_processing_file', @current_processing_file
      #     L.kv '@current_state', current_state
      #     L.kv '@current_register_file', @current_register_file
    
      #     L.exception(exception)          
      #   end
      #   @current_processing_file = nil
      # end

      # def load_file(file, path_expansion: true)
      #   file = expand_path(file) if path_expansion

      #   # L.kv 'load_file.file', file

      #   @current_state = :load_file
      #   @current_register_file = file

      #   content = File.read(file)

      #   process_code(:load_file, content)

      #   @current_register_file = nil
      #   @current_state = :dynamic
      # end

      # def load_dynamic(content)
      #   @current_state = :dynamic
      #   @current_register_file = nil

      #   process_code(:dynamic, content)

      #   @current_register_file = nil
      #   @current_state = :dynamic
      # end

      # def save(dsl)
      #   unique_key = build_unique_key(dsl.k_key, dsl.namespace, dsl.type)
      #   # L.kv 'action', 'save(dsl)'
      #   # L.kv '@current_state', current_state
      #   # L.kv '@unique_key', unique_key

      #   case @current_state
      #   when :register_file
      #     save_register_file(unique_key, dsl.k_key, dsl.namespace, dsl.type)
      #   when :load_file
      #     save_load_file(unique_key, dsl.k_key, dsl.namespace, dsl.type, dsl)
      #   when :dynamic
      #     save_dynamic(unique_key, dsl.k_key, dsl.namespace, dsl.type, dsl)
      #   else
      #     raise 'unknown state'
      #   end

      #   dsl
      # end

      # def build_unique_key(key, namespace = nil, type = :entity)
      #   namespace.blank? ? "#{key}_#{type}" : "#{namespace}_#{key}_#{type}" 
      # end

      # def dsl_exist?(key, namespace = nil, type = :entity)
      #   dsl = get_dsl(key, namespace, type)

      #   !dsl.nil?
      # end

      # def get_dsl(key, namespace = nil, type = :entity)
      #   unique_key = build_unique_key(key, namespace, type)

      #   @dsls[unique_key]
      # end

      # def get_dsls_by_type(k_type = :entity, namespace = nil)
      #   if namespace.nil?
      #     @dsls.values.select { |dsl| dsl[:k_type] == k_type }
      #   else
      #     @dsls.values.select { |dsl| dsl[:namespace] == namespace && dsl[:k_type] == k_type }
      #   end
      # end

      # def get_data(key, namespace = nil, type = :entity)
      #   dsl = get_dsl(key, namespace, type)

      #   raise "Could not get data for missing DSL: #{build_unique_key(key, namespace, type)}" if dsl.nil?

      #   load_data_from_dsl(dsl)
      # end

      # def load_data_from_dsl(dsl)
      #   # Need to load this file
      #   if dsl[:state] == :registered
      #     load_file(dsl[:file])
      #   end

      #   dsl[:data]
      # end
            
      # def get_relative_folder(fullpath)
      #   absolute_path = Pathname.new(fullpath)
      #   project_root  = Pathname.new(base_dsl_path)
      #   relative      = absolute_path.relative_path_from(project_root)
      #   rel_dir, file = relative.split
        
      #   rel_dir.to_s
      # end

      # def debug(include_header = false)
      #   if include_header
      #     L.heading 'Register DSL'
      #     print_main_properties
      #     L.line
      #   end
        
      #   print_dsls
      # end

      # def print_main_properties
      #   # L.kv 'base_dsl_path'            , base_dsl_path
      #   # L.kv 'base_data_path'           , base_data_path
      #   # L.kv 'base_definition_path'     , base_definition_path
      #   # L.kv 'current_state'            , current_state
      #   # L.kv 'current_register_file'    , current_register_file
      #   # L.kv 'current_processing_file'  , current_processing_file
      # end

      # def print_dsls
      #   # tp dsls.values, :k_key, :k_type, :state, :save_at, :last_at, :data, :last_data, :source, { :file => { :width => 150 } }, { :rel_folder => { :width => 80 } }
      #   tp dsls.values, :namespace, :k_key, :k_type, :state, :save_at, :data, :source, { :file => { :width => 50 } }, { :rel_folder => { :width => 80 } }
      # end

      # private

      def guard_source_file(file)
        # if file.blank?
        #   # L.info 'no source files'
        # end

        return unless !file.nil? && !file.starts_with?(*@watch_paths)

        L.kv 'file', file
        raise KDsl::Error, 'Source file skipped, file is not on a registered path'
      end

      # def default_dsl_data(**data)
      #   { 
      #     namespace: nil,
      #     k_key: nil, 
      #     k_type: nil,
      #     state: nil, 
      #     save_at: nil,
      #     last_at: nil,
      #     data: nil,
      #     last_data: nil,
      #     source: nil, 
      #     file: nil,
      #     rel_folder: nil
      #   }.merge(data)
      # end

      # def save_register_file(unique_key, key, namespace, type)
      #   k = @dsls[unique_key]
    
      #   if k.present? && k[:file].present? && k[:file] != @current_register_file
      #     print_dsls

      #     L.line
      #     L.kv 'Error', 'Duplicate DSL key found'
      #     L.kv 'Unique Key', unique_key
      #     L.kv 'Namespace', namespace
      #     L.kv 'Key', key
      #     L.kv 'Type', type
      #     L.kv 'File', @current_register_file
      #     L.line
      #     print
      #     L.line

      #     raise Klue::Dsl::DslError, "Duplicate DSL key found #{unique_key} in different files"
      #   end
    
      #   if k.present?
      #     L.line
      #     L.kv 'Warning', 'DSL already registered'
      #     L.kv 'Unique Key', unique_key
      #     L.kv 'Namespace', namespace
      #     L.kv 'Key', key
      #     L.kv 'Type', type
      #     L.kv 'Previous File Name', k[:file]
      #     L.kv 'Register File Name', @current_register_file
      #     L.line
      #     print
      #     L.line
      #   else
      #     @dsls[unique_key] = default_dsl_data(
      #       namespace: namespace,
      #       k_key: key, 
      #       k_type: type, 
      #       state: :registered,
      #       source: :file,
      #       file: @current_register_file,
      #       rel_folder: get_relative_folder(@current_register_file)
      #     )
      #   end
      # end

      # def save_load_file(unique_key, key, namespace, type, dsl)
      #   k = @dsls[unique_key]

      #   if k.nil?
      #     # New Record
      #     @dsls[unique_key] = default_dsl_data(
      #       namespace: namespace,
      #       k_key: key, 
      #       k_type: type, 
      #       state: :loaded,
      #       save_at: Time.now.utc,
      #       data: dsl.get_data(),
      #       source: :file,
      #       file: @current_register_file,
      #       rel_folder: get_relative_folder(@current_register_file)
      #     )
      #   else
      #     # Update Record
      #     k[:state] = :loaded
      #     k[:last_at] = k[:save_at]
      #     k[:save_at] = Time.now.utc
      #     k[:last_data] = k[:data]
      #     k[:data] = dsl.get_data()
      #   end
      # end

      # def save_dynamic(unique_key, key, namespace, type, dsl)
      #   k = @dsls[unique_key]

      #   if k.nil?
      #     # New Record
      #     @dsls[unique_key] = default_dsl_data(
      #       namespace: namespace,
      #       k_key: key,
      #       k_type: type, 
      #       state: :loaded,
      #       save_at: Time.now.utc,
      #       data: dsl.get_data(),
      #       source: :dynamic
      #     )
      #   else
      #     # Update Record
      #     k[:state] = :loaded
      #     k[:last_at] = k[:save_at]
      #     k[:save_at] = Time.now.utc
      #     k[:last_data] = k[:data]
      #     k[:data] = dsl.get_data()
      #   end
      # end

      # This makes more sense at an APP level, instead of a project level
      # def self.reset
      #   @@instance = nil
      # end

      # def self.get_instance
      #   # Note: if you have already created an instance using custom code then it will re-used
      #   @@instance
      # end
    end
  end
end
