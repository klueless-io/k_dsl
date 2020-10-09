# frozen_string_literal: true
require 'pry'

BASE_PATH = '~/dev/kweb/klue-less/_'

namespace :k_dsl do
  desc 'Execute the KLUE DSL'

  # WHY did I have environement?
  # task :run, [:dsl_file] => :environment do |_task, args|
  task :run, [:dsl_file] do |_task, args|
    require 'k_dsl'

    file = args[:dsl_file]

    10.times { puts '' }

    KDsl.setup(log_level: KDsl::LOG_INFO)

    config_command = KDsl::Manage::ProjectConfig.new do |config|
      config.base_path = BASE_PATH
      config.base_resource_path = config.base_path
    end

    project_command = KDsl::Manage::Project.new('quick_commands', config_command)
    project_command.watch_path('microapp/_cmds/**/*.rb')

    config_microapp = KDsl::Manage::ProjectConfig.new do |config|
      config.base_path = BASE_PATH
      config.base_resource_path = '~/dev/kgems/k_dsl/spec/factories/dsls'
    end

    project_microapp1 = KDsl::Manage::Project.new('microapp1', config_microapp) do
      watch_path('common-auth/**/*.rb')
      watch_path('microapp1/**/*.rb')
    end

    project_microapp2 = KDsl::Manage::Project.new('microapp2', config_microapp) do
      watch_path('microapp2/**/*.rb')
    end

    project_sample = KDsl::Manage::Project.new('sample', config_microapp) do
      watch_path('data_files/**/*.*')
      watch_path('ruby_files/**/*.rb', ignore: /ruby3.rb$/)
      watch_path('simple_dsl/**/*.rb')
    end

    manager = KDsl.project_manager

    # manager.add_project(project_command)
    # manager.add_project(project_microapp1)
    # manager.add_project(project_microapp2)
    manager.add_project(project_sample)
    # manager.register_all_resource_documents
    # manager.load_all_documents
    
    2.times { puts '' }
    manager.debug(format: :detail, project_formats: [:watch_path_patterns, :resource, :resource_document])

    # dsl1 = project_sample.get_dsl('my_name1')
    # document1 = dsl1[:document]
    # document1.debug(include_header: true)

    # dsl2 = project_sample.get_dsl('my_name2')
    # document2 = dsl2[:document]
    # # document2.debug(include_header: true)
    # document2.execute_block(run_actions: true)

    # listener = project_sample.watch
    # manager.watch
    # listener.stop
    # manager.run('/Users/davidcruwys/dev/kgems/k_dsl/spec/factories/dsls/simple_dsl/two_dsl.rb')
    # manager.watch
    # KDsl.process.file(file)

  end
end
