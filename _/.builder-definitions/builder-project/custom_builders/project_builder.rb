log.kv 'load', 'project_builder' if AppDebug.require?

class ProjectBuilder
  attr_accessor :builder
  attr_accessor :projects
  attr_reader :project
  attr_reader :project_definition
  # attr_accessor :entities

  def initialize(builder, projects)
    @builder = builder
    @projects = projects
    @project = nil
    @project_definition = nil

    log.kv 'projects', projects.length
  end

  def set_project(name: nil, project: nil)
    # puts 1
    return guard_log("project or project name is required") if name.nil? && project.nil?

    @project_definition = nil
    # puts 2
    @project = project || @projects.find { |p| p.name == name }
    # puts 3

    return guard_log("project not found, could not set project: #{name}") if @project.nil?
    # puts 4
    return guard_log("target folder not configured for project: #{name || @project.name}") if @project.app_path.nil?

    # puts 5

    @project_definition = ProjectDefinition.instance(builder, @project)
  rescue => exception
    log.error(exception.message)
  end

  def create
    return guard_log('project not set, could not create project') if @project.nil || @project_definition.nil?
    # puts 6

    project_definition.create
    # puts 7
  end

  def delete
    return guard_log('project not set, could not delete project') if @project.nil || @project_definition.nil?
    # puts 8

    project_definition.delete
    # puts 9
  end

  private

  def guard_log(message)
    log.error message
  end

  # def solution_exists?
  #   file = "#{AppSettings.current.solution.application}.sln"
  #   solution_file = File.join(builder.target_folders.get(:root), file)

  #   File.exist?(solution_file)
  # end

  # def new_solution
  #   log.section_heading 'New solution'

  #   if solution_exists?
  #     log.error('Solution already exists')
  #     return
  #   end

  #   builder.cd(:root).rc('dotnet new sln')
  # end

  # def new_projects
  #   log.section_heading 'New projects'

  #   project_list.active.each do |project|
  #     new_project(project)
  #     attach_to_solution(project)
  #   end
  # end

  # def new_project(project)
  #   builder.cd(project.name)

  #   file = "#{project.application}.csproj"
  #   project_file = File.join(builder.target_folder, file)

  #   if File.exist?(project_file)
  #     log.error("Project already exists: #{project.application}")
  #     return
  #   end

  #   builder.rc("dotnet new #{project.project_dotnet_type} -n #{project.application} -o .")
  # end

  # def attach_to_solution(project)
  #   return unless solution_exists?

  #   builder
  #     .cd(:root)
  #     .rc("dotnet sln add #{project.application_lib_path}/#{project.application}.csproj")
  # end

  # # ----------------------------------------------------------------------
  # # Add klueless builder project for DotNet project
  # # ----------------------------------------------------------------------

  # def new_project_builders
  #   log.section_heading 'New project builders'

  #   project_list.active.each do |project|
  #     new_project_builder(project)
  #   end
  # end

  # def new_project_builder(project)
  #   log.section_heading project.name
  #   log.open_struct(project)

  #   builder
  #     .cd("#{project.name}_builder".to_sym)
  #     .add_file('config/_.rb'                 , template_file: 'def/_.rb')
  #     .add_file('config/builder_config.rb'    , template_file: 'def/builder_config.rb',
  #       solution: AppSettings.current.solution,
  #       project: project
  #     )
  #     .add_file('config/builder_options.rb'   , template_file: 'def/builder_options.rb')
  #     .add_file('config/project_setup.rb'     , template_file: 'def/project_setup.rb',
  #       solution: AppSettings.current.solution,
  #       project: project
  #     )
  #     .add_file('config/project_code.rb'      , template_file: 'def/project_code.rb',
  #       solution: AppSettings.current.solution,
  #       project: project
  #     )
  #     .add_file('setup.rb'                    , template_file: 'def/setup.rb',
  #       solution: AppSettings.current.solution,
  #       project: project
  #     )
  # end

  # private

  # def update_target_folders
  #   # root = @builder_config.target_folders.get(:root)
  #   project_list.active.each do |project|
  #     @builder.target_folders.add(project.name, :root, project.application_lib_path)
  #     @builder.target_folders.add("#{project.name}_builder".to_sym, :root, project.application_lib_path, '.builders')
  #   end
  # rescue => exception
  #   
  # end
end