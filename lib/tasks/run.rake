# frozen_string_literal: true
require 'pry'

BASE_PATH_OLD = '~/dev/kweb/klue-less/_'

BASE_PATH = '~/dev/kgems/k_dsl/_'
BASE_PATH_RESOURCES = '~/dev/kgems/k_dsl/_projects'

namespace :k_dsl do
  def build_project(relative_resource_path)
    project_config = get_config(relative_resource_path: relative_resource_path)
    project = KDsl::Manage::Project.new(relative_resource_path, project_config)
    project.watch_path('**/*.rb')
    project
  end

  desc 'Execute the KLUE DSL'
  
  # WHY did I have environnement?
  # task :run, [:dsl_file] => :environment do |_task, args|
  task :run, [:dsl_file] do |_task, args|
    require 'k_dsl'

    file = args[:dsl_file]

    10.times { puts '' }

    KDsl.setup(log_level: KDsl::LOG_NONE) # LOG_INFO

    # Add any extra extensions that you require on documents
    KDsl::Model::Document.include(KDsl::Extensions::CommandRunnable) # Documents can run command line programs
    KDsl::Model::Document.include(KDsl::Extensions::CreateDsl)       # Documents can create a new DSL from their relative position
    KDsl::Model::Document.include(KDsl::Extensions::GithubLinkable)  # Documents can add, delete or open repos
    KDsl::Model::Document.include(KDsl::Extensions::HttpResourceful) # Documents can connect to HTTP resources
    KDsl::Model::Document.include(KDsl::Extensions::Importable)      # Documents can import data from other documents
    KDsl::Model::Document.include(KDsl::Extensions::Writable)        # Documents can write their contents out to the cache path in JSON or YAML
    
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

    # Peeky
    project_peeky_config = get_config(relative_resource_path: 'kgems/peeky',
                                      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/peeky/.templates')
    project_peeky = KDsl::Manage::Project.new('peeky', project_peeky_config)
    project_peeky.watch_path('**/*.rb', ignore: /.template/)

    # rspec-usecases
    project_rspec_usecases_config = get_config(relative_resource_path: 'kgems/rspec-usecases',
                                               app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/rspec-usecases/.templates')
    project_rspec_usecases = KDsl::Manage::Project.new('rspec-usecases', project_rspec_usecases_config)
    project_rspec_usecases.watch_path('**/*.rb', ignore: /.template/)


    # handlebars-helpers
    project_handlebars_helpers_config = get_config(relative_resource_path: 'kgems/handlebars-helpers',
                                                   app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/handlebars-helpers/.templates')
    project_handlebars_helpers = KDsl::Manage::Project.new('handlebars-helpers', project_handlebars_helpers_config)
    project_handlebars_helpers.watch_path('**/*.rb', ignore: /.template/)
    project_handlebars_helpers.watch_path('~/dev/kgems/handlebars-helpers/.handlebars*.json')

    # C# - Samples (Programs)
    project_cs_p02_config = get_config(relative_resource_path: 'c#/P02Ef4')
    project_cs_p02 = KDsl::Manage::Project.new('c#/P02Ef4', project_cs_p02_config)
    project_cs_p02.watch_path('**/*.rb')

    project_cs_p03 = build_project('c#/p03_domain_models')
    project_cs_p04_domain_monopoly_v1 = build_project('c#/p04_domain_monopoly_v1')
    current_cs = project_cs_p04_domain_monopoly_v1

    # HTML - Samples (Lessons)
    project_html_l01_config = get_config(relative_resource_path: 'html/l01_ux_design_principals')
    project_html_l01 = KDsl::Manage::Project.new('html/l01_ux_design_principals', project_html_l01_config)
    project_html_l01.watch_path('**/*.rb')

    project_html_l02 = build_project('html/l02_bootstrap_getting_started')
    project_html_l03 = build_project('html/l03_sample_app')
    
    # project_html_l04 = build_project('html/l04_transpiler_babel')
    project_html_l04 = build_project('html/l04_transpiler_swc')

    # Webpack (By Example)
    project_webpack5_transpiler_babel = build_project('webpack5/transpiler_babel')
    project_webpack5_transpiler_swc = build_project('webpack5/transpiler_swc')
    project_webpack5_transpiler_typescript = build_project('webpack5/transpiler_typescript')
    project_webpack5_html_multi_page = build_project('webpack5/html_multi_page')

    current_webpack5 = project_webpack5_html_multi_page

    # REACT - Samples (React)

    project_react_l02 = build_project('react/r02_component_state_function')
    project_react_l03 = build_project('react/r03_props')

    current_react = project_react_l03

    # KDSL
    project_gem_kdsl_config = get_config(relative_resource_path: 'kgems/k_dsl',
                                         app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_dsl/.templates')

    project_gem_kdsl = KDsl::Manage::Project.new('k_dsl', project_gem_kdsl_config)
    project_gem_kdsl.watch_path('**/*.rb')

    project_idea = KDsl::Manage::Project.new('idea', get_config(relative_resource_path: 'idea'))
    project_idea.watch_path('**/*.rb')

    project_idea_post = KDsl::Manage::Project.new('idea_post', get_config(relative_resource_path: 'idea_post'))
    project_idea_post.watch_path('**/*.rb')

    project_idea_video = KDsl::Manage::Project.new('idea_video', get_config(relative_resource_path: 'idea_video'))
    project_idea_video.watch_path('**/*.rb')

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

    group = %i[current handlebars_helpers rspec_usecases peeky k_dsl ideas play_loquacious xyz_commands].first

    case group
    when :current
      manager.add_projects(project_command,
                           # project_rspec_usecases,
                           # project_idea_video,
                           # project_html_l04,
                           #  current_react,
                          #  current_cs,
                            current_webpack5
                          )
    when :xyz_commands
      manager.add_projects(project_command,
                           project_k_xmen_command,
                           project_k_ymen_command,
                           project_k_zmen_command,
                           project_gem_kdsl)
    when :k_dsl
      manager.add_projects(project_command, project_gem_kdsl)
    when :ideas
      manager.add_projects(project_command, project_idea, project_idea_post, project_idea_video)
    when :play_loquacious
      manager.add_projects(project_command, project_playrb_loquacious)
    when :peeky
      manager.add_projects(project_command, project_peeky)
    when :rspec_usecases
      manager.add_projects(project_command, project_rspec_usecases)
    when :handlebars_helpers
      manager.add_projects(project_command, project_handlebars_helpers)

    when :cs_p02
      manager.add_projects(project_command, project_cs_p02)
    end
    # manager.add_projects(project_microapp1,
    #                      project_microapp2,
    #                      project_sample)

    manager.register_all_resource_documents
    manager.load_all_documents
    
    2.times { puts '' }
    manager.debug(format: :detail, project_formats: [:watch_path_patterns, :resource, :resource_document])

    manager.watch
  end
end
