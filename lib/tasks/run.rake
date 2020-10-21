# frozen_string_literal: true
require 'pry'

BASE_PATH_OLD = '~/dev/kweb/klue-less/_'

BASE_PATH = '~/dev/kgems/k_dsl/_'
BASE_PATH_RESOURCES = '~/dev/kgems/k_dsl/_projects'

namespace :k_dsl do
  desc 'Execute the KLUE DSL'

  # WHY did I have environnement?
  # task :run, [:dsl_file] => :environment do |_task, args|
  task :run, [:dsl_file] do |_task, args|
    require 'k_dsl'

    file = args[:dsl_file]

    10.times { puts '' }

    KDsl.setup(log_level: KDsl::LOG_INFO)

    # Add any extra extensions that you require on documents
    KDsl::Model::Document.include(KDsl::Extensions::CommandRunnable) # Documents can run command line programs
    KDsl::Model::Document.include(KDsl::Extensions::CreateDsl)      # Documents can create a new DSL from their relative position
    KDsl::Model::Document.include(KDsl::Extensions::GithubLinkable) # Documents can add, delete or open repos
    KDsl::Model::Document.include(KDsl::Extensions::Importable)     # Documents can import data from other documents
    KDsl::Model::Document.include(KDsl::Extensions::Writable)       # Documents can write their contents out to the cache path in JSON or YAML
    
    # Add any extra extensions for factory methods
    KDsl.extend(KDsl::Extensions::DocumentFactories)

    def get_config(path: BASE_PATH, resource_path: BASE_PATH_RESOURCES, relative_resource_path: nil, app_template_path: nil)
      resource_path = File.join(resource_path, relative_resource_path) if relative_resource_path.present?
      config = KDsl::Manage::ProjectConfig.new do
        self.base_path = path
        self.base_resource_path = resource_path
      end

      config.base_app_template_path = app_template_path if app_template_path.present?
      
      config
    end  

    config_command = KDsl::Manage::ProjectConfig.new do
      self.base_path = BASE_PATH
      self.base_resource_path = BASE_PATH_RESOURCES
    end

    project_command = KDsl::Manage::Project.new('quick_commands', get_config)
    project_command.watch_path('cmd/**/*.rb')

    project_k_xmen_command = KDsl::Manage::Project.new('k_xmen', get_config(relative_resource_path: 'kcmd/k_xmen'))
    project_k_xmen_command.watch_path('**/*.rb')

    project_k_ymen_command = KDsl::Manage::Project.new('k_ymen', get_config(relative_resource_path: 'kcmd/k_ymen'))
    project_k_ymen_command.watch_path('**/*.rb')

    project_k_zmen_command = KDsl::Manage::Project.new('k_zmen', get_config(relative_resource_path: 'kcmd/k_zmen'))
    project_k_zmen_command.watch_path('**/*.rb')

    project_playrb_loquacious = KDsl::Manage::Project.new('playrb_loquacious', get_config(relative_resource_path: 'kgems/playrb_loquacious'))
    project_playrb_loquacious.watch_path('**/*.rb')

    project_gem_kdsl_config = get_config(relative_resource_path: 'kgems/k_dsl',
                                         app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_dsl/.templates')

    project_gem_kdsl = KDsl::Manage::Project.new('k_dsl', project_gem_kdsl_config)
    project_gem_kdsl.watch_path('**/*.rb')

    project_idea = KDsl::Manage::Project.new('idea', get_config(relative_resource_path: 'idea/idea'))
    project_idea.watch_path('**/*.rb')

    project_idea_post = KDsl::Manage::Project.new('idea_post', get_config(relative_resource_path: 'idea_post/idea_post'))
    project_idea_post.watch_path('**/*.rb')

    config_microapp = KDsl::Manage::ProjectConfig.new do
      self.base_path = BASE_PATH
      self.base_resource_path = '~/dev/kgems/k_dsl/spec/factories/dsls'
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
      # watch_path('ruby_files/ruby3.rb')
      # watch_path('data_files/sample.csv')
      # watch_path('simple_dsl/two_dsl.rb')
    end

    manager = KDsl.project_manager

    group = %i[ideas xyz_commands play_loquacious kdsl].first

    case group
    when :xyz_commands
      manager.add_projects(project_command,
                          project_k_xmen_command,
                          project_k_ymen_command,
                          project_k_zmen_command,
                          project_gem_kdsl)
    when :k_dsl
      manager.add_projects(project_command, project_gem_kdsl)
    when :ideas
      manager.add_projects(project_command, project_idea, project_idea_post)
    when :play_loquacious
      manager.add_projects(project_command, project_playrb_loquacious)
    end
    # manager.add_projects(project_microapp1,
    #                      project_microapp2,
    #                      project_sample)

    manager.register_all_resource_documents
    manager.load_all_documents
    
    2.times { puts '' }
    manager.debug(format: :detail, project_formats: [:watch_path_patterns, :resource, :resource_document])

    # dsl1 = project_sample.get_dsl('my_name1')
    # document1 = dsl1[:document]
    # document1.debug(include_header: true)

    # resource_document = project_sample.get_resource_document('my_name').document
    # resource_document.debug(include_header: true)
    # resource_document.execute_block(run_actions: true)


    # resource_document1 = project_sample.get_resource_document('my_name1').document
    # resource_document1.debug(include_header: true)
    # resource_document1.execute_block(run_actions: true)

    # resource_document2 = project_sample.get_resource_document('my_name2').document
    # resource_document2.debug(include_header: true)
    # resource_document2.execute_block(run_actions: true)
    # manager.debug(format: :simple, project_formats: [:resource_document])

    manager.watch

  end
end
