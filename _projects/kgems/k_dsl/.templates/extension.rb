# frozen_string_literal: true

module KDsl
  module {{camel blueprint.settings.output_rel_path}}
    module {{camel blueprint.settings.name}}
      # {{titleize blueprint.settings.name}}
      def {{snake blueprint.settings.name}}
        return warn('{{titleize blueprint.settings.name}} skipped: Document not linked to a project') if !defined?(project) || project.nil?

        L.kv '{{titleize blueprint.settings.name}}'
      end
    end
  end
end