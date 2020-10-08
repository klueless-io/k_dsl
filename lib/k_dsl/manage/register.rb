# frozen_string_literal: true

module KDsl
  module Manage
    class Register
      # @@instance = nil

      attr_reader :dsls                         # List of DSL's instances

      # There is currently a tight cupling between is boolean and DSL's so that they know whether they are being refrenced for registration or importation
      # The difference is that importation will execute their interal code block while registration will not.
      # attr_reader :current_state
      # attr_reader :current_register_file

      # attr_reader :register_paths

      # what file is currently being processed
      # attr_reader :current_processing_file

      # def initialize(base_resource_path, base_cache_path = nil, base_definition_path = nil, base_template_path = nil, base_app_template_path = nil)
      #   @base_resource_path = base_resource_path.is_a?(Pathname) ? base_resource_path.to_s : base_resource_path
        
      #   @dsls = {}
      #   @current_state = :dynamic
      #   @current_register_file = nil
      #   @register_paths = []
      # end

      # def self.reset
      #   @@instance = nil
      # end

      # def self.get_instance
      #   # Note: if you have already created an instance using custom code then it will re-used
      #   @@instance
      # end

      # def self.create(base_resource_path, base_cache_path: nil, base_definition_path: nil, base_template_path: nil, &block)
      #   # L.kv 'create1', '@@instance is Present'  if @@instance.present?
      #   # L.kv 'create1', '@@instance is Nil'      if @@instance.nil?

      #   if @@instance.nil?
      #     # L.heading 'in create'
      #     # L.kv 'dsl', base_resource_path; 
      #     # L.kv 'data', base_cache_path

      #     @@instance = new(base_resource_path, base_cache_path, base_definition_path, base_template_path)
      #     @@instance.instance_eval(&block) if block_given?

      #   end

      #   @@instance
      # end

      # private_class_method :new
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

      # def get_dsls_by_type(k_type = :entity, namespace = nil)
      #   if namespace.nil?
      #     @dsls.values.select { |dsl| dsl[:k_type] == k_type }
      #   else
      #     @dsls.values.select { |dsl| dsl[:namespace] == namespace && dsl[:k_type] == k_type }
      #   end
      # end

      # def get_data(key, namespace = nil, type = :entity)
      #   dsl = get_dsl(key, type, namespace)

      #   raise "Could not get data for missing DSL: #{build_unique_key(key, type, namespace)}" if dsl.nil?

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
      #     File.expand_path(filename, base_resource_path)
      #   end
      # end

      # def get_relative_folder(fullpath)
      #   absolute_path = Pathname.new(fullpath)
      #   project_root  = Pathname.new(base_resource_path)
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
      #   # L.kv 'base_resource_path'            , base_resource_path
      #   # L.kv 'base_cache_path'           , base_cache_path
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

      # def save_register_file(unique_key, key, type, namespace)
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

      # def save_load_file(unique_key, key, type, namespace, dsl)
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

      # def save_dynamic(unique_key, key, type, namespace, dsl)
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
    end
  end
end
