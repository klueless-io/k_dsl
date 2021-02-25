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

  # Add any extra extensions that you require on documents
  KDsl::Model::Document.include(KDsl::Extensions::CommandRunnable) # Documents can run command line programs
  KDsl::Model::Document.include(KDsl::Extensions::CreateDsl)       # Documents can create a new DSL from their relative position
  KDsl::Model::Document.include(KDsl::Extensions::GithubLinkable)  # Documents can add, delete or open repos
  KDsl::Model::Document.include(KDsl::Extensions::HttpResourceful) # Documents can connect to HTTP resources
  KDsl::Model::Document.include(KDsl::Extensions::Importable)      # Documents can import data from other documents
  KDsl::Model::Document.include(KDsl::Extensions::Writable)        # Documents can write their contents out to the cache path in JSON or YAML
  
  KDsl.extend(KDsl::Extensions::DocumentFactories)
end
