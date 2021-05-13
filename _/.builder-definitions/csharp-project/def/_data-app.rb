puts "_DATA_APP"

def app
  return @app if defined? @app
  @app = begin
    app = {
      support_mssql: false,
      support_pgsql: true,
      database_name: '',
      application_namespaces: [{{safe project.namespaces}}]
    }
    app[:application_namespace] = app[:application_namespaces].join('.')
    app
  end      
end
