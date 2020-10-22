module KDsl
  module Extensions
    module Writable
      # Provides file write extensions that can output document data to
      # the CachePath
      #
      # Currently used as an extension to document
      def write_json(is_edit: false, with_meta: false)
        # Add support for namespace
        file = "#{project.config.base_cache_path}/#{key}_#{type}#{(with_meta ? '.meta' : '')}.json"

        o = (with_meta ? data : raw_data)

        # L.block "write_json #{file}"
        write_as o, file, is_edit: is_edit

        file
      end

      def write_yaml(is_edit: false, with_meta: false)
        # Add support for namespace
        file = "#{project.config.base_cache_path}/#{key}_#{type}#{(with_meta ? '.meta' : '')}.yaml"

        o = (with_meta ? data : raw_data)

        # L.block "write_yaml #{file}"
        write_as o, file, is_edit: is_edit

        file
      end

      def write_html(is_edit: false, with_meta: false, template: nil, template_file: nil)
        # Add support for namespace
        file = "#{project.config.base_cache_path}/#{key}_#{type}#{(with_meta ? '.meta' : '')}.html"

        o = (with_meta ? data : raw_data)

        # L.block "write_json #{file}"
        write_as o, file, is_edit: is_edit, template: template, template_file: template_file

        file
      end

      # Write data as some output type
      #
      # Output type can derived from the file extension (.yaml, .yml, .json)
      # or it can specified with the optional :as_type
      def write_as(data, file, as_type: nil, is_edit: false, template: nil, template_file: nil)
        return warn('Write As Skipped: Document not linked to a project') if !defined?(project) || project.nil?

        # L.kv 'file', file
        # L.kv 'as_type', as_type
        # L.kv 'is_edit', is_edit
        # L.kv 'data', data

        full_file = File.expand_path(file, project.config.base_cache_path)
        # L.kv 'full_file', full_file

        if as_type.nil?
          ext = File.extname(full_file)
          as_type = :yaml if ext.casecmp('.yaml').zero? || ext.casecmp('.yml').zero?
          as_type = :json if ext.casecmp('.json').zero?
          as_type = :html if ext.casecmp('.html').zero?
        end

        # L.kv 'file', file
        # L.kv 'ext', ext
        # L.kv 'as_type', as_type

        raise KDsl::Error, 'Provide a valid extension or as_type. Supported types: [json, yaml]' unless [:json, :yaml, :html].include?(as_type)

        FileUtils.mkdir_p(File.dirname(full_file))

        File.write(full_file, JSON.pretty_generate(data)) if as_type == :json
        File.write(full_file, data.to_yaml)               if as_type == :yaml

        if as_type == :html
          template = '<html></html>' if template.nil?
          template = File.read(template.file) if template_file.present? && File.exist?(template_file)

          output = KDsl::TemplateRendering::TemplateHelper.process_template(template, data)
          File.write(full_file, output)
        end

        system("code #{full_file}")                       if is_edit
      end

      private

      # Need a better way of integrating warning into document
      def writable_warn(message)
        L.warn message
        nil
      end
    end
  end
end