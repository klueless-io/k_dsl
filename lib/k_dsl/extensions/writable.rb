module KDsl
  module Extensions
    module Writable
      # TODO: Refactor which_data as it is a mess
      def which_data(with_meta: false, custom_data: nil)
        if custom_data.nil?
          with_meta == true ? raw_data : data
        else
          # This is bad, I don't really know what is being passed in, it could already be a hash
          KDsl::Util.data.struct_to_hash(custom_data)
        end
      end

      # Provides file write extensions that can output document data to
      # the CachePath
      #
      # Currently used as an extension to document
      def write_json(is_edit: false, with_meta: false, custom_data: nil)
        # Add support for namespace
        file = "#{project.config.base_cache_path}/#{key}_#{type}#{(with_meta ? '.meta' : '')}.json"

        o = which_data(with_meta: with_meta, custom_data: custom_data)

        # L.block "write_json #{file}"
        write_as o, file, is_edit: is_edit

        file
      end

      def write_yaml(is_edit: false, with_meta: false, custom_data: nil)
        # Add support for namespace
        file = "#{project.config.base_cache_path}/#{key}_#{type}#{(with_meta ? '.meta' : '')}.yaml"

        o = which_data(with_meta: with_meta, custom_data: custom_data)

        # L.block "write_yaml #{file}"
        write_as o, file, is_edit: is_edit

        file
      end

      def write_html(is_edit: false, with_meta: false, template: nil, template_file: nil, output_file: nil, custom_data: nil)
        # Add support for namespace
        file = "#{project.config.base_cache_path}/#{key}_#{type}#{(with_meta ? '.meta' : '')}.html"

        o = which_data(with_meta: with_meta, custom_data: custom_data)

        # L.block "write_json #{file}"
        write_as o, file, is_edit: is_edit, template: template, template_file: template_file, output_file: output_file

        file
      end

      def write_clipboard(template: nil, template_file: nil, with_meta: false, custom_data: nil)
        output = write_to_s(template: template, template_file: template_file, with_meta: with_meta, custom_data: custom_data)

        IO.popen('pbcopy', 'w') { |f| f << output }
        
        output
      end

      def write_to_s(template: nil, template_file: nil, with_meta: false, custom_data: nil)
        data = which_data(with_meta: with_meta, custom_data: custom_data)

        render_template(data, template, template_file)
      end

      def render_template(data, template, template_file)
        template = '' if template.nil?
        if template_file.present? && File.exist?(template_file)
          template = File.read(template_file)
        end

        KDsl::TemplateRendering::TemplateHelper.process_template(template, data)
      end

      # Write data as some output type
      #
      # Output type can derived from the file extension (.yaml, .yml, .json)
      # or it can specified with the optional :as_type
      def write_as(data, file, as_type: nil, is_edit: false, template: nil, template_file: nil, output_file: nil)
        return warn('Write As Skipped: Document not linked to a project') if !defined?(project) || project.nil?

        L.kv 'file', file
        L.kv 'as_type', as_type
        L.kv 'is_edit', is_edit
        L.kv 'data', data

        full_file = if output_file.present?
          output_file
        else
          File.expand_path(file, project.config.base_cache_path)
        end

        # full_file = File.expand_path(file, project.config.base_cache_path)
        # L.kv 'full_file', full_file

        if as_type.nil?
          ext = File.extname(full_file).strip.downcase[1..-1]
          as_type = ext.to_sym if ext.present?
          as_type = :yaml if as_type == :yml
        end

        # L.kv 'file', file
        # L.kv 'ext', ext
        # L.kv 'as_type', as_type

        # raise KDsl::Error, 'Provide a valid extension or as_type. Supported types: [json, yaml]' unless [:json, :yaml, :html].include?(as_type)

        FileUtils.mkdir_p(File.dirname(full_file))

        case as_type
        when :json
          File.write(full_file, JSON.pretty_generate(data))
        when :yaml
          File.write(full_file, data.to_yaml)
        else
          output = render_template(data, template, template_file)
          File.write(full_file, output)
        end

        system("code #{full_file}")                       if is_edit

        file
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