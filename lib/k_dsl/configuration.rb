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

    attr_accessor :modifiers

    def initialize
      @default_document_type = :entity
      @default_settings_key = :settings
      @default_rows_key = :rows

      @modifiers = default_modifiers
    end

    def get_modifier(key)
      @modifiers[key]
    end

    private

    def default_modifiers
      {
        uppercase: KDsl::Modifier::UppercaseModifier,
        lowercase: KDsl::Modifier::LowercaseModifier
      }
    end
  end
end

KDsl.config = KDsl::Configuration.new
