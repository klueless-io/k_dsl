# frozen_string_literal: true

module KDsl
  module Resources
    # Yaml Resource represents a YAMLx data structure in the project
    class YamlResource < Resource
      def initialize(project:, source:, file:, watch_path: nil, content: nil)
        super(project: project, source: source, file: file, watch_path: watch_path)#, content: content)

        self.type = KDsl::Resources::Resource::TYPE_YAML
      end

      def register
        @document = add_document(new_document)
        project.add_resource_document(self, @document)
      end

      # Where is register in all this?
      def load
        data = YAML.load(content)
        @document.set_data(data)
      end

      def debug
        L.ostruct(KDsl::Util.data.to_struct(@document.data))
      end
    end
  end
end
