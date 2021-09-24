log.kv 'load', 'project_definition' if AppDebug.require?

class ProjectDefinition
  attr_accessor :builder
  attr_accessor :project
  attr_accessor :project_folder_key
  attr_accessor :target_folder
  attr_accessor :language
  attr_accessor :type
  attr_accessor :variant

  def initialize(builder, project, language:, type:, variant:)
    # puts 'a1'
    @builder = builder
    # puts 'a2'
    @project = project
    # puts 'a3'
    @target_folder = File.expand_path(@project.app_path)
    # puts 'a4'
    @language = language
    # puts 'a5'
    @type = type
    # puts 'a6'
    @variant = variant
    # puts 'a7'
    @project_folder_key = "project_#{@project.name}".to_sym
    @builder.target_folders.add(@project_folder_key, @target_folder)
    
    # log.info @target_folder
  end

  def fork_command(command)
    # k_builder-watch seems like it is locked up because it starts a watch process of it's own
    tf = @builder.target_folders.get(project_folder_key)
    build_command = "cd #{tf} && #{command}"

    fork { exec(build_command) }
  end

  def run_command(command)
    builder
      .cd(project_folder_key)
      .run_command(command)
  end

  def exist?
    Dir.exist?(target_folder)
  end

  def delete
    # puts 'a11'
    log.warn "you cannot delete #{message}"
    # puts 'a12'
  end
  
  def create
    # puts 'a21'
    return guard_log("skipping #{message} - folder already exists...") if exist?
    # puts 'a22'
    if project.new_project_command
      run_command(project.new_project_command)
      log.debug "#{message} folder was created"
    else
      log.info "about to create #{message}"
    end
    # puts 'a23'
  end
  
  def bootstrap
    log.info "about to bootstrap #{message}"
    # puts 'a31'
    # bootstrap the project with improved boilerplate code
  end

  class << self
    def instance(builder, project)
      # puts 'b1'
      raise "Invalid project type :#{project.type}" unless map.key?(project.type)
      # project.type is mapping to :key in map
      # type is a new definition that makes sense for code generation
      # SMELL: project.type and map.type are overloaded here
      proj = map[project.type]
      proj[:klass].new(builder, project, language: proj[:language], type: proj[:type], variant: proj[:variant])
    end
  
    def map
      @map ||= {
        root_folder: {
          language: :unknown,
          type: :root,
          variant: nil,
          klass: RootProject
        },
        domain_modal: {
          language: :ruby,
          type: :builder,
          variant: :domain_modal,
          klass: BuilderProject
        },
        rails: {
          language: :ruby,
          type: :rails,
          variant: nil,
          klass: RailsProject
        },
        react: {
          language: :javascript,
          type: :react,
          variant: nil,
          klass: ReactProject
        },
        react_native: {
          language: :javascript,
          type: :react_native,
          variant: nil,
          klass: ReactNativeProject
        }
      }
    end
  end

  protected

  def message
    titleize.parse([variant, type].compact.join(' '))
  end

  def guard_log(msg)
    log.warn msg
  end
end

class RootProject < ProjectDefinition
  def delete
    log.warn "you cannot delete the #{message} folder"
  end  
end

class BuilderProject < ProjectDefinition
  def exist?
    builder_folder = File.join(target_folder, '.builders')
    super && Dir.exist?(builder_folder)
  end

  def create
    return guard_log("skipping #{message} - folder already exists...") if exist?

    run_command(project.new_project_command)
    log.debug "#{message} folder was created"
  end

  def bootstrap
    log.info "about to bootstrap #{message}"
    # puts 'a31-x'
    builder
      .cd(project_folder_key) # need subfolder support. eg. cd(project_folder_key, '.builders')
      .add_file('.builders/config/_.rb'                               , content_file: 'config/_.rb')
      .add_file('.builders/config/app_settings.rb'                    , content_file: 'config/app_settings.rb')
      .add_file('.builders/config/builder_options.rb'                 , content_file: 'config/builder_options.rb')
      .add_file('.builders/config/configure_builder.rb'               , content_file: 'config/configure_builder.rb')
      .add_file('.builders/custom_actions/_.rb'                       , content_file: 'custom_actions/_.rb')
      .add_file('.builders/custom_actions/create_projects.rb'         , content_file: 'custom_actions/create_projects.rb')
      .add_file('.builders/custom_actions/new_builder.rb'             , content_file: 'custom_actions/new_builder.rb')
      .add_file('.builders/custom_builders/_.rb'                      , content_file: 'custom_builders/_.rb')
      .add_file('.builders/helpers/_.rb'                              , content_file: 'helpers/_.rb')
      .add_file('.builders/helpers/builder_options_class_helper.rb'   , content_file: 'helpers/builder_options_class_helper.rb')
      .add_file('.builders/initializers/_.rb'                         , content_file: 'initializers/_.rb')
      .add_file('.builders/initializers/_final.rb'                    , content_file: 'initializers/_final.rb')
      .add_file('.builders/initializers/handlebars_helpers.rb'        , content_file: 'initializers/handlebars_helpers.rb')
      .add_file('.builders/setup.rb'                                  , content_file: 'setup.rb')
      .add_file('.builders/readme.md'                                 , content_file: 'readme.md')
  end

  def delete
    builder_folder = File.join(target_folder, '.builders')
    FileUtils.rm_rf(builder_folder)
    log.debug "#{message} folder was deleted"
  end  
end

class RailsProject < ProjectDefinition
  def exist?
    project_file = File.join(target_folder, 'Gemfile')
    super && File.exist?(project_file)
  end
end

class ReactProject < ProjectDefinition
  def exist?
    project_file = File.join(target_folder, 'package.json')
    super && File.exist?(project_file)
  end
end

class ReactNativeProject < ProjectDefinition
  def exist?
    project_file = File.join(target_folder, 'package.json')
    super && File.exist?(project_file)
  end
end

# bundle gem --coc --test=rspec --mit k_builder-dotnet
# bundle gem --coc --test=rspec --mit k_builder-watch
# dotnet new web -n P14MovieTheatre -o .
# dotnet new mvc -n P15Areas -o .
# dotnet new gitignore -o .
# rails new . -T -d postgresql --force --webpack=react --skip-git --skip-action-mailer --skip-action-mailbox --skip-action-text
# npx create-react-app .
# npx expo init .
# npx expo init r03-movie-request -t expo-template-blank-typescript
# npx expo start
