# frozen_string_literal: true

module KDsl
  module Extensions
    module {{camel blueprint_settings.name}}
      # {{titleize blueprint_settings.name}}
      def {{snake blueprint_settings.name}}
        return warn('{{titleize blueprint_settings.name}} skipped: Document not linked to a project') if !defined?(project) || project.nil?

        L.kv '{{titleize blueprint_settings.name}}'
      end
    end
  end
end