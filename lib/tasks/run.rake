# frozen_string_literal: true

namespace :k_dsl do
  desc 'Execute the KLUE DSL'

  # WHY did I have environement?
  # task :run, [:dsl_file] => :environment do |_task, args|
  task :run, [:dsl_file] do |_task, args|
    require 'k_dsl'

    file = args[:dsl_file]

    KDsl.setup
    KDsl.process.file(file)

    # # THIS is now an App (or a projects)
    # Klue.process(file) do

    #   # THIS is now a manager
    #   # Klue.register(File.join(Rails.root, '_')) do
    #   #   L.block "Register for #{CURRENT_RUNNERS[CURRENT_RUNNER][:name]}"

    #   #   register_path('microapp/_cmds/**/*.rb')

    #   #   register_path('artifact/common-auth/**/*.rb')
    #   #   register_path('blueprint/rails6/**/*.rb')
    #   #   register_path('microapp/achievement-badge/**/*.rb')
    #   # end
    # end
  end
end
