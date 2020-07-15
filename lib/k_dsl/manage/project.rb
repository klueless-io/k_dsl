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
      # attr_reader :dsls                         # List of DSL's instances

      # There is currently a tight cupling between is boolean and DSL's so that they know whether they are being refrenced for registration or importation
      # The difference is that importation will execute their interal code block while registration will not.
      # attr_reader :current_state
      # attr_reader :current_register_file

      attr_reader :dsl_paths

      # what file is currently being processed
      # attr_reader :current_processing_file

      # def initialize(base_dsl_path, base_data_path = nil, base_definition_path = nil, base_template_path = nil, base_app_template_path = nil)
      #   @base_dsl_path = base_dsl_path.is_a?(Pathname) ? base_dsl_path.to_s : base_dsl_path

      attr_reader :config

      def initialize(config = nil)
        @config = config || KDsl::Manage::ProjectConfig.new

        @dsls = {}
        # @current_state = :dynamic
        # @current_register_file = nil
        @dsl_paths = []
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

      # def register_path(path)
      #   path = expand_path(path)

      #   Dir[path].sort.each do |file|
      #     @dsl_paths << File.dirname(file) unless @dsl_paths.include? File.dirname(file)
      #     register_file(file, path_expansion: false)
      #   end
      # end

      # def process_code(caller, code, source_file = nil)
      #   # L.kv 'process_code.caller', caller
      #   # L.kv 'process_code.source_file', source_file
        
      #   @current_processing_file = source_file

      #   if source_file.blank?
      #     # L.info 'no source files'
      #   end

      #   if source_file.present? && !source_file.starts_with?(*@dsl_paths)
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

      # def register_file(file, path_expansion: true)
      #   file = expand_path(file) if path_expansion

      #   # L.kv 'register_file.file', file

      #   @current_state = :register_file
      #   @current_register_file = file

      #   content = File.read(file)

      #   process_code(:register_file, content)
    
      #   @current_register_file = nil
      #   @current_state = :dynamic
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
            
      # def is_pathname_absolute(pathname)
      #   Pathname.new(pathname).absolute?
      # end

      # def expand_path(filename)
      #   if is_pathname_absolute(filename)
      #     filename
      #   elsif filename.start_with?('~/')
      #     File.expand_path(filename)
      #   else
      #     File.expand_path(filename, base_dsl_path)
      #   end
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
