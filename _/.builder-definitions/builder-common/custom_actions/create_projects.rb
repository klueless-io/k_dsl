log.warn 'create_projects' if AppDebug.require?

def action_create_projects
  project_builder = ProjectBuilder.new(builder, app.projects)
  # project_builder.set_project(opts.create_project.name)
  # project_builder.create
  # or
  app.projects.each do |project|
    project_builder.set_project(project: project)
    project_builder.create
    # project_builder.delete
    # project_builder.create
  end
end