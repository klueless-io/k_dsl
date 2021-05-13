class ProjectCode
  ADMIN_VIEWS = ['Create', 'Delete', 'Details', 'Edit', 'Index', '_Fields']

  attr_accessor :builder
  attr_accessor :solution
  attr_accessor :project
  attr_accessor :entities
  
  attr_accessor :project_flag
  attr_accessor :project_code

  def initialize(builder, solution_settings, project_settings, entities, opts)
    @builder              = builder
    @solution             = KUtil.data.to_open_struct(solution_settings)
    @project              = KUtil.data.to_open_struct(project_settings)
    @entities             = entities
    @project_code         = opts.project_code
    @project_flag         = opts.project_flag
  end

  def execute
    builder.cd(:project)

    add_starter_code      if project_code.add_starter_code
    add_documents         if project_code.add_documents
    add_ef_entities       if project_code.add_ef_entities
    add_ef_context        if project_code.add_ef_context
    add_entity_admin      if project_code.add_entity_admin
  end

  private

  # ----------------------------------------------------------------------
  # Add structures
  # ----------------------------------------------------------------------

  def add_starter_code
    add_starter_code_web if project.project_dotnet_type == :web
  end

  def add_starter_code_web
    builder.add_file('Program.cs', template_file: 'Program.cs', project: project)
    builder.add_file('Startup.cs', template_file: 'Startup.cs', project: project)
    builder.add_file('Controllers/HomeController.cs', template_file: 'Controllers/HomeController.cs', project: project)
    builder.add_file('Models/ErrorViewModel.cs', template_file: 'Models/ErrorViewModel.cs', project: project)

    copy_folder(:csharp_web, 'Views')
    copy_folder(:csharp_web, 'wwwroot')
  rescue => exception
    log.error(exception.message)
    log.warn("maybe the :csharp_web folder is not configured")
  end

  def copy_folder(template_key, subfolder)
    source_folder = builder.template_folders.join(template_key, subfolder)
    target_folder = builder.target_folders.join(:project, subfolder)
    FileUtils.copy_entry source_folder, target_folder
  end

  def add_documents
    builder
      .add_file('Readme.md'                             , template_file: 'Readme.md')
      .add_file('docs/code_of_conduct.md'               , template_file: 'docs/CODE_OF_CONDUCT.md')
      .add_file('docs/licence.txt'                      , template_file: 'docs/LICENSE.txt')
      .add_file('docs/stories.md'                       , template_file: 'docs/STORIES.md')
      .add_file('docs/usage.md'                         , template_file: 'docs/USAGE.md')
  end
  
  def add_ef_context
    log.info 'Add DomainContext'
    builder.add_file('Context/DomainContext.cs'         , template_file: 'Context/DomainContext.cs',
      project: project,
      entities: entities)

    if project_flag.use_sql_server
      log.info 'Setting up ef context for SQL Server'

      builder.add_file('Context/MsDbContext.cs'         , template_file: 'Context/MsDbContext.cs', project: project)
    end
    
    if project_flag.use_pgsql
      log.info 'Setting up ef context for PostgreSql'

      builder.add_file('Context/PgDbContext.cs'         , template_file: 'Context/PgDbContext.cs', project: project)
    end
  end

  def add_entity_admin
    log.info 'add_entity_admin'

    builder.add_file("Views/Shared/_AdminMenuItems.cshtml",
      template_file: 'Views/Shared/_AdminMenuItems.cshtml',
      project: project,
      entities: entities)

    entities.each do |entity|
      name = camel.parse(entity.name.to_s)
      builder.add_file("Controllers/#{name}Controller.cs",
        template_file: 'Admin/Controller.cs',
        project: project,
        entity: entity)

      ADMIN_VIEWS.each do |action|
        builder.add_file("Views/#{name}/#{action}.cshtml",
          template_file: "Admin/Views/#{action}.cshtml",
          project: project,
          entity: entity)
      end
    end
  end

  def add_ef_entities
    entities.each do |entity|
      name = camel.parse(entity.name.to_s)
      builder.add_file("Data/#{name}.cs"              , template_file: 'Data/Model.cs', project: project, entity: entity)
      # builder.add_file("#{name}.designer.cs"     , template_file: 'Data/Model.designer.cs', project: project, entity: entity)
    end
  end
end