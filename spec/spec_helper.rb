# frozen_string_literal: true

require 'pry'
require 'bundler/setup'
require 'k_dsl'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.filter_run_when_matching :focus

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  KDsl::Model::Document.include(KDsl::Extensions::CommandRunable)
  KDsl::Model::Document.include(KDsl::Extensions::CreateDsl)
  KDsl::Model::Document.include(KDsl::Extensions::GithubLinkable)
  KDsl::Model::Document.include(KDsl::Extensions::Importable)
  KDsl::Model::Document.include(KDsl::Extensions::Writable)

  KDsl.extend(KDsl::Extensions::DocumentFactories)
end
