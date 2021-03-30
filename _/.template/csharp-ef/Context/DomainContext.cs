namespace {{app.application_namespace}}.Context
{
  using Microsoft.EntityFrameworkCore;
  using {{app.application_namespace}}.Models;

  public class DomainContext : DbContext
  {
    {{#each entities}}
    public DbSet<{{camel name}}> {{format_as name 'camel,pluralize'}} { get; set; }

    {{/each}}
  }
}
