# frozen_string_literal: true

module KDsl
  module Resources
    # Resource represents a file in the project 
    #
    # Resources currently represent DSL's but I think I can have support for
    # other types of files such as (PORO, Ruby, JSON, CSV) and be able to use
    # them easily.
    class Resource
      # If data is loaded into the resource, then it will usually take the form of a Hash 
      attr_reader :raw_data

      # Provides an OpenStruct wrapper around the raw data
      attr_reader :data

      # Store an exeption that may exist
      attr_reader :error

      # Currently supports read from file, but will support read from HTTP in the future
      SOURCE_FILE = 'file'

      # Not implement
      # SOURCE_URI = 'uri'
      # SOURCE_DYNAMIC = 'dynamic'

      TYPE_UNKNOWN = 'unknown'
      TYPE_CSV = 'csv'
      TYPE_JSON = 'json'
      TYPE_RUBY = 'ruby'
      TYPE_RUBY_DSL = 'dsl'

      attr_reader :project

      # Source of the content
      #
      # :file, :uri, :dynamic
      attr_reader :source

      # Type of resource
      attr_accessor :type

      # Full file path
      #
      # example: /Users/davidcruwys/dev/kgems/k_dsl/spec/factories/dsls/common-auth/admin_user.rb
      attr_reader :file

      # If the file is watched, what was it's base watch path
      #
      # Currently only used for informational/debugging purpose
      #
      # example: /Users/davidcruwys/dev/kgems/k_dsl/spec/factories/dsls/common-auth
      attr_reader :watch_path

      # Content of resource, use read content to load this property
      attr_reader :content

      # NOTE: I have an idea that multiple artifacts could be derived from a resource
      # EXAMPLE: You may define two Klue.structures inside of a single DSL file
      # This means that artifact should be in it's own class and either linked as a 
      # single instance or as an array.

      # REFACT: I think I want to refactor documents so that the onlyt thing that exists is
      #         ResourceDocument
      #         that way I have looser coupling and the ability to both register and load
      #         can be cleaned up
      attr_reader :documents
      attr_reader :artifact

      def initialize(project: nil, source: nil, file: nil, watch_path: nil, content: nil)
        @project = project
        @source = source
        @file = file
        @watch_path = watch_path
        @content = content
        @documents = []
      end

      def self.instance(project:, source: KDsl::Resources::Resource::SOURCE_FILE, file: nil, watch_path: nil)
        raise ::KDsl::Error, 'Unknown source' unless [SOURCE_FILE].include? source

        content = source === SOURCE_FILE && File.exist?(file) ? File.read(file) : nil

        klass = resource_class(source, file, content)

        klass.new(
            project: project,
            source: source,
            file: file,
            watch_path: watch_path,
            content: content)
      end

      def self.resource_class(source, file, content)
        if source === SOURCE_FILE
          extension = File.extname(file).downcase

          case extension
          when '.rb'
            return content&.include?('KDsl.document') ? DslResource : RubyResource
          when '.csv'
            return CsvResource
          when '.json'
            return JsonResource
          end
        end

        return UnknownResource
      end

      def add_new_document(key, type, namespace, data = nil)
        document = KDsl::Model::Document.new(key, type, namespace: namespace)
        document.set_data(data) if data

        add_document(document)
      end

      def add_document(document)
        documents << document
      end

      # REFACT: RENAME: RegisterResourceDocuments
      def register_documents
        L.warn "Do not know how to register #{type} resources"
      end
      alias register register_documents

      def load
        L.warn "Do not know how to load #{type} resources"
      end
  
      def exist?
        source === SOURCE_FILE && File.exist?(file)
      end

      # example:  ~/dev/kgems/k_dsl/spec/factories/dsls
      def relative_watch_path
        @relative_watch_path ||= watch_path.delete_prefix(base_resource_path_expanded)
      end

      # example:  ~/dev/kgems/k_dsl/spec/factories/dsls
      def filename
        @filename ||= File.basename(file)
      end

      # example:  ~/dev/kgems/k_dsl/spec/factories/dsls
      def base_resource_path
        project.config.base_dsl_path
      end

      # example:  /Users/david/dev/kgems/k_dsl/spec/factories/dsls
      def base_resource_path_expanded
        @base_resource_path ||=  File.expand_path(project.config.base_dsl_path)
      end

      def infer_document_key
        if filename
          ext = File.extname(filename)
          case ext
          when '.json', '.csv', '.yaml'
            File.basename(filename)
          else
            File.basename(filename, File.extname(filename))
          end
        else
          'undetermined'
        end
      end
    end
  end
end
