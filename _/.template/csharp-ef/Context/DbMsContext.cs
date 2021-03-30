namespace {{app.application_namespace}}.Context
{
  using Microsoft.EntityFrameworkCore;

  public class DbMsContext : DomainContext
  {
    public DbMsContext()
    {
    }

    protected override void OnConfiguring(DbContextOptionsBuilder options)
        => options.UseSqlServer("Server=localhost,1433; Database=P06;User=sa; Password=||env DEVELOPER_PASSWORD||");
  }
}
