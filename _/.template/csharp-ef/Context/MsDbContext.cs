namespace {{project.application_namespace}}.Context
{
  using Microsoft.EntityFrameworkCore;

  // Database context for PostgresSql database
  public class MsDbContext : DomainContext
  {
    public MsDbContext()
    {
    }

    public MsDbContext(DbContextOptions<MsDbContext> options)
    {
    }

    private string Password
    {
      get
      {
        return System.Environment.GetEnvironmentVariable("DEVELOPER_PASSSWORD");
      }
    }

    protected override void OnConfiguring(DbContextOptionsBuilder options)
      => options.UseSqlServer($"Server=localhost,1433; Database={{camel app.database_name}};User=sa; Password={Password}");
  }
}
