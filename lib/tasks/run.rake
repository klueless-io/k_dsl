# frozen_string_literal: true

namespace :k_dsl do
  desc 'Execute the KLUE DSL'

  # WHY did I have environement?
  # task :run, [:dsl_file] => :environment do |_task, args|
  task :run, [:dsl_file] do |_task, args|
    require 'k_dsl'

    file = args[:dsl_file]

    KDsl.setup

    # KDsl.setup
    # KDsl.project_manager.config do
    #   project('microap1', '~/dev/gems/k_dsl/spec/factories/dsls') do
    #     register_path('common-auth/**/*.rb')
    #     register_path('microapp1/**/*.rb')
    #   end
    # end
    # KDsl.process.file(file)

  end
end
