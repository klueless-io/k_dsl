# frozen_string_literal: true

module KDsl
  module Resources
    # Resource represents a file in the project 
    #
    # Resources currently represent DSL's but I think I can have support for
    # other types of files such as (PORO, Ruby, JSON, CSV) and be able to use
    # them easily.
    class Resource

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

      # Source of the content
      #
      # :file, :uri, :dynamic
      attr_reader :source

      # Type of resource
      attr_accessor :type

      # Full file path
      attr_reader :file

      # If the file is watched, what was it's base watch path
      #
      # Currently only used for informational/debugging purpose
      attr_reader :watch_path

      # Content of resource, use read content to load this property
      attr_reader :content

      def initialize(source: nil, file: nil, watch_path: nil, content: nil)
        @source = source
        @file = file
        @watch_path = watch_path
        @content = content
      end

      def self.instance(source: nil, file: nil, watch_path: nil)
        raise Klue::Dsl::DslError 'Unknown source' unless [SOURCE_FILE].include? source

        extension = File.extname(file).downcase
        content = source === SOURCE_FILE && File.exist?(file) ? File.read(file) : nil

        case extension
        when '.rb'
          # Very primitive DSL check, needs improvement
          return DslResource.new(source: source, file: file, watch_path: watch_path, content: content) if content.include?('KDsl::')
          return RubyResource.new(source: source, file: file, watch_path: watch_path, content: content)
        when '.csv'
          return CsvResource.new(source: source, file: file, watch_path: watch_path, content: content)
        when '.json'
          return JsonResource.new(source: source, file: file, watch_path: watch_path, content: content)
        end

        return UnknownResource.new(source: source, file: file, watch_path: watch_path, content: content)
      end

      def exist?
        source === SOURCE_FILE && File.exist?(file)
      end
    end
  end
end
