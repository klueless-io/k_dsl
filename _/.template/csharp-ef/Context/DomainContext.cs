namespace {{project.application_namespace}}.Context
{
  using {{project.application_namespace}}.Data;
  using Microsoft.EntityFrameworkCore;

  public partial class DomainContext : DbContext
  {
    {{#each entities}}
    public DbSet<{{camel name}}> {{format_as name 'camel,pluralize'}} { get; set; }
    {{/each}}
  }
}
