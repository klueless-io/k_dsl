# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

task build: :compile

Rake::ExtensionTask.new('k_dsl') do |ext|
  ext.lib_dir = 'lib/k_dsl'

  # https://andyatkinson.com/blog/2014/06/23/sharing-rake-tasks-in-gems
  import './lib/tasks/run.rake'
end

task default: %i[clobber compile spec]
