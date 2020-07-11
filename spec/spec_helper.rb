# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'k_dsl'
require 'k_dsl/modifier/processor'
require 'k_dsl/modifier/uppercase_modifier'
require 'k_dsl/modifier/lowercase_modifier'
require 'k_dsl/dsl_error'
require 'k_dsl/dsl_invalid_type_error'
require 'k_dsl/configuration'
require 'k_dsl/document_dsl'
require 'k_dsl/settings_dsl'
require 'k_dsl/table_dsl'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
