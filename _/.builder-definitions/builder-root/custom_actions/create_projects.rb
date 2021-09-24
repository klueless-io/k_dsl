log.kv 'load', 'create_projects' if AppDebug.require?

class CreateProjects
  class << self
    def execute(opts)
      # puts 'x1'
      create_projects = CreateProjects.new(opts)
      # puts 'x2'
      create_projects.execute
    end
  end

  attr_accessor :opts

  def initialize(opts)
    @opts = opts
  end

  def execute
    # puts 'x3'
    project_builder = ProjectBuilder.new(builder, app.projects, opts.filter_project_name)
    # puts 'x4'

    project_builder.project_list.each do |project|
      # puts 'x5'
      log.kv 'project', project.name
      # puts 'x6'
      project_builder.current_project(project)
      # puts 'x7'
      project_builder.delete        if opts.delete
      # puts 'x8'
      project_builder.create        if opts.create
      # puts 'x9'
      project_builder.bootstrap     if opts.bootstrap
      # puts 'x10'
      
    end
  end
end
