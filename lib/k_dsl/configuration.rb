# frozen_string_literal: true

# Provide access to the DSL Configuration
module KDsl
  # Config will need to be available on a per App/DSL namespace?
  # This is because when you run two different DSL's at the same time
  # you may ned to instantiate different classes and have different
  # default keys and modifiers based on the app space.
  class << self
    attr_accessor :config
  end

  # This is just a fake config for now
  class Configuration
    attr_accessor :document_class
    attr_accessor :settings_class
    attr_accessor :table_class

    attr_accessor :default_document_type
    attr_accessor :default_settings_key
    attr_accessor :default_table_key

    attr_accessor :modifiers

    def initialize
      @default_document_type = :entity
      @default_settings_key = :settings
      @default_table_key = :table

      @document_class = KDsl::Model::Document
      @table_class = KDsl::Model::Table
      @settings_class = KDsl::Model::Settings

      @modifiers = default_modifiers
    end

    def get_modifier(key)
      @modifiers[key]
    end

    private

    # This needs to be configured from the App Space
    # but there may also be global modifiers like these two.
    def default_modifiers
      {
        uppercase: KDsl::Modifier::UppercaseModifier,
        lowercase: KDsl::Modifier::LowercaseModifier
      }
    end
  end
end

KDsl.config = KDsl::Configuration.new
