# frozen_string_literal: true
require 'pry'

BASE_PATH_OLD = '~/dev/kweb/klue-less/_'

BASE_PATH = '~/dev/kgems/k_dsl/_'
BASE_PATH_RESOURCES = '~/dev/kgems/k_dsl/_projects'

# rake k_dsl:run
namespace :k_dsl do
  def build_project(relative_resource_path, app_template_path: nil)
    project_config = get_config(relative_resource_path: relative_resource_path, app_template_path: app_template_path)
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

    # Rails
    project_rails_printspeakx = build_project('rails/printspeakx')
    current_rails = project_rails_printspeakx

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

    # app-builder
    project_k_doc_config = get_config(relative_resource_path: 'kgems/k_doc',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_doc/.templates')
    project_k_doc = KDsl::Manage::Project.new('k_doc', project_k_doc_config)
    project_k_doc.watch_path('**/*.rb', ignore: /.template/)

    project_k_github_config = get_config(relative_resource_path: 'kgems/k_github',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_github/.templates')
    project_k_github = KDsl::Manage::Project.new('k_github', project_k_github_config)
    project_k_github.watch_path('**/*.rb', ignore: /.template/)

    project_k_ext_github_config = get_config(relative_resource_path: 'kgems/k_ext-github',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_ext-github/.templates')
    project_k_ext_github = KDsl::Manage::Project.new('k_ext-github', project_k_ext_github_config)
    project_k_ext_github.watch_path('**/*.rb', ignore: /.template/)

    project_k_type_config = get_config(relative_resource_path: 'kgems/k_type',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_type/.templates')
    project_k_type = KDsl::Manage::Project.new('k_type', project_k_type_config)
    project_k_type.watch_path('**/*.rb', ignore: /.template/)

    project_k_util_config = get_config(relative_resource_path: 'kgems/k_util',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_util/.templates')
    project_k_util = KDsl::Manage::Project.new('k_util', project_k_util_config)
    project_k_util.watch_path('**/*.rb', ignore: /.template/)

    project_k_decor_config = get_config(relative_resource_path: 'kgems/k_decor',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_decor/.templates')
    project_k_decor = KDsl::Manage::Project.new('k_decor', project_k_decor_config)
    project_k_decor.watch_path('**/*.rb', ignore: /.template/)

    project_k_log_config = get_config(relative_resource_path: 'kgems/k_log',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_log/.templates')
    project_k_log = KDsl::Manage::Project.new('k_log', project_k_log_config)
    project_k_log.watch_path('**/*.rb', ignore: /.template/)

    project_k_manager_config = get_config(relative_resource_path: 'kgems/k_manager',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_manager/.templates')
    project_k_manager = KDsl::Manage::Project.new('k_manager', project_k_manager_config)
    project_k_manager.watch_path('**/*.rb', ignore: /.template/)

    project_k_builder_config = get_config(relative_resource_path: 'kgems/k_builder',
          app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_builder/.templates')
    project_k_builder = KDsl::Manage::Project.new('k_builder', project_k_builder_config)
    project_k_builder.watch_path('**/*.rb', ignore: /.template/)

    project_k_builder_watch_config = get_config(relative_resource_path: 'kgems/k_builder-watch',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_builder-watch/.templates')
    project_k_builder_watch = KDsl::Manage::Project.new('k_builder-watch', project_k_builder_watch_config)
    project_k_builder_watch.watch_path('**/*.rb', ignore: /.template/)

    project_k_builder_dotnet_config = get_config(relative_resource_path: 'kgems/k_builder-dotnet',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_builder-dotnet/.templates')
    project_k_builder_dotnet = KDsl::Manage::Project.new('k_builder-dotnet', project_k_builder_dotnet_config)
    project_k_builder_dotnet.watch_path('**/*.rb', ignore: /.template/)

    project_k_builder_package_json_config = get_config(relative_resource_path: 'kgems/k_builder-package_json',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_builder-package_json/.templates')
    project_k_builder_package_json = KDsl::Manage::Project.new('k_builder-package_json', project_k_builder_package_json_config)
    project_k_builder_package_json.watch_path('**/*.rb', ignore: /.template/)

    project_k_builder_webpack5_config = get_config(relative_resource_path: 'kgems/k_builder-webpack5',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/k_builder-webpack5/.templates')
    project_k_builder_webpack5 = KDsl::Manage::Project.new('k_builder-webpack5', project_k_builder_webpack5_config)
    project_k_builder_webpack5.watch_path('**/*.rb', ignore: /.template/)

    # webpack5-builder
    project_webpack5_builder_config = get_config(relative_resource_path: 'kgems/webpack5-builder',
     app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/webpack5-builder/.templates')
    project_webpack5_builder = KDsl::Manage::Project.new('webpack5-builder', project_webpack5_builder_config)
    project_webpack5_builder.watch_path('**/*.rb', ignore: /.template/)

    project_mindmeister_api_config = get_config(relative_resource_path: 'kgems/mindmeister_api',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/mindmeister_api/.templates')
    project_mindmeister_api = KDsl::Manage::Project.new('mindmeister_api', project_mindmeister_api_config)
    project_mindmeister_api.watch_path('**/*.rb', ignore: /.template/)

    # print_speak
    project_print_speak_config = get_config(relative_resource_path: 'kgems/print_speak',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/print_speak/.templates')
    project_print_speak = KDsl::Manage::Project.new('print_speak', project_print_speak_config)
    project_print_speak.watch_path('**/*.rb', ignore: /.template/)

    project_test_miniracer_config = get_config(relative_resource_path: 'kgems/test-miniracer',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/test-miniracer/.templates')
    project_test_miniracer = KDsl::Manage::Project.new('test-miniracer', project_test_miniracer_config)
    project_test_miniracer.watch_path('**/*.rb', ignore: /.template/)

    project_test_gpt3 = KDsl::Manage::Project.new('test_gpt3', get_config(relative_resource_path: 'kgems/test_gpt3'))
    project_test_gpt3.watch_path('**/*.rb')

    project_gpt3_builder_config = get_config(relative_resource_path: 'kgems/gpt3-builder',
      app_template_path: '~/dev/kgems/k_dsl/_projects/kgems/gpt3-builder/.templates')
    project_gpt3_builder = KDsl::Manage::Project.new('gpt3-builder', project_gpt3_builder_config)
    project_gpt3_builder.watch_path('**/*.rb', ignore: /.template/)


    # C# - Samples (Programs)
    project_cs_p02_config = get_config(relative_resource_path: 'c#/P02Ef4')
    project_cs_p02 = KDsl::Manage::Project.new('c#/P02Ef4', project_cs_p02_config)
    project_cs_p02.watch_path('**/*.rb')

    project_cs_p03 = build_project('c#/p03_domain_models')
    project_cs_p04_domain_monopoly_v1 = build_project('c#/p04_domain_monopoly_v1')
    project_cs_p05_mvc_app = build_project('c#/p05_mvc_app')
    project_cs_p06_sales_terminal = build_project('c#/p06_sales_terminal')
    project_cs_p07_weather_microservice = build_project('c#/p07_weather_microservice', app_template_path: '~/dev/c#/P07WeatherMicroservice/_/app/.templates')
    project_cs_p08_mvc_basic = build_project('c#/p08_mvc_basic')
    project_cs_p09_mvc_bootstrap_plugins = build_project('c#/p09_mvc_bootstrap_plugins')
    project_cs_p10_mvc_with_identity = build_project('c#/p10_mvc_with_identity')

    project_cs_pitstop = build_project('csharp/pitstop')
    project_cs_peterpan = build_project('csharp/peterpan')
    project_cs_p11_club_membership = build_project('csharp/p11_club_membership')
    project_cs_p12_location = build_project('csharp/p12_location')
    project_cs_printspeak = build_project('csharp/printspeak')
    project_cs_courses = build_project('csharp/p13_courses')
    project_cs_movies = build_project('csharp/p14_movie_theatre')
    project_cs_movies = build_project('csharp/p15_areas')

    current_cs = project_cs_movies

    # HTML - Samples (Lessons)
    project_html_l01_config = get_config(relative_resource_path: 'html/l01_ux_design_principals')
    project_html_l01 = KDsl::Manage::Project.new('html/l01_ux_design_principals', project_html_l01_config)
    project_html_l01.watch_path('**/*.rb')

    project_html_l02 = build_project('html/l02_bootstrap_getting_started')
    project_html_l03 = build_project('html/l03_sample_app')
    
    # project_html_l04 = build_project('html/l04_transpiler_babel')
    project_html_l04 = build_project('html/l04_transpiler_swc')
    project_html_l05 = build_project('html/l05_bootstrap_components')
    project_html_l06 = build_project('html/l06_responsive_html')
    project_html_l07 = build_project('html/l07_monopoly_board')
    current_html = project_html_l07

    # Webpack (By Example)
    project_webpack5_transpiler_babel = build_project('webpack5/transpiler_babel')
    project_webpack5_transpiler_swc = build_project('webpack5/transpiler_swc')
    project_webpack5_transpiler_typescript = build_project('webpack5/transpiler_typescript')
    project_webpack5_html_multi_page = build_project('webpack5/html_multi_page')

    current_webpack5 = project_webpack5_html_multi_page

    # REACT - Samples (React)

    project_react_l02 = build_project('react/r02_component_state_function')
    project_react_l03 = build_project('react/r03_props')
    project_react_l04 = build_project('react/r04_react_router')
    project_react_l05 = build_project('react/r05_storage')
    project_react_l06 = build_project('react/r06_monopoly')

    current_react = project_react_l06

    project_react_native_l01 = build_project('react_native/r01_getting_started')
    project_react_native_l02 = build_project('react_native/r02_navigation')
    
    current_react_native = project_react_native_l02
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
    project_idea_video.watch_path('**/*.rb', ignore: /template_code/)

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
                           # project_print_speak
                           # project_rspec_usecases,
                           # project_webpack5_builder,
                          #  project_idea_video,
                           # current_html
                           # current_react,
                           # current_react_native,
                           # current_rails,
                          #  current_cs,
                           # current_webpack5
                           # project_k_builder_watch, project_k_builder_dotnet, project_k_builder_webpack5, project_k_builder_package_json, project_k_builder
                           # project_k_type,
                           # project_k_ext_github
                           # project_k_doc,
                           # project_k_manager,
                           # project_k_log,
                           # project_k_util,
                           # project_k_decor,
                           #  project_mindmeister_api
                          #  project_test_miniracer
                           project_gpt3_builder
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
