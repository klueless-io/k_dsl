# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in poc_github_ap.gemspec
gemspec

group :development, :test do
  gem 'guard-bundler'
  gem 'guard-rspec'
  # pry on steroids
  # gem 'pry-coolline', github: 'owst/pry-coolline', branch: 'support_new_pry_config_api'
  gem 'jazz_fingers'
  gem 'rake'
  # this is used for cmdlets 'self-executing gems'
  gem 'rake-compiler'
  gem 'rspec', '~> 3.0'
  gem 'rubocop'
  gem 'guard-rake'
  gem "peeky"

  # Debugging code needs to be decoupled from k_dsl
  gem 'table_print'
end
