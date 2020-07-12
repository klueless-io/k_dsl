# frozen_string_literal: true

# Provide access to the DSL Configuration
module KDsl
  # Will config need to be available from a per App/DSL namespace?
  # I think so if you want to run two different DSL's at the same time.
  class << self
    attr_accessor :config
  end

  # This is just a fake config for now
  class Configuration
    # NEW Concept
    # attr_accessor :document_class
    # attr_accessor :settings_class
    # attr_accessor :table_class

    # Rename settings & rows
    attr_accessor :default_document_type
    attr_accessor :default_settings_key
    attr_accessor :default_table_key

    attr_accessor :modifiers

    def initialize
      @default_document_type = :entity
      @default_table_key = :table
      @default_settings_key = :settings

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
