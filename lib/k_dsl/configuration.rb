# frozen_string_literal: true

# Provide access to the DSL Configuration
module KDsl
  class << self
    attr_accessor :config
  end

  # This is just a fake config for now
  class Configuration
    attr_accessor :default_document_type
    attr_accessor :default_settings_key
    attr_accessor :default_rows_key

    attr_accessor :visitors

    def initialize
      @default_document_type = :entity
      @default_settings_key = :settings
      @default_rows_key = :rows

      @visitors = []
    end
  end
end

KDsl.config = KDsl::Configuration.new
