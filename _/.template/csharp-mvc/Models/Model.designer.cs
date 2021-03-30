namespace {{#each blueprint.settings.application_namespace}}{{.}}{{#if @last}}{{else}}.{{/if}}{{/each}}
{
  using System.Collections.Generic;
  using System.ComponentModel.DataAnnotations.Schema;
  using Microsoft.EntityFrameworkCore;

  public partial class {{camel blueprint.settings.name}}
  {
    public int Id { get; set; }

    // Attributes
    {{#each blueprint.attributes.rows}}
    public {{type}} {{camel name}} { get; set; }
    {{/each}}

    // 0-1
    // public Garden Garden { get; set; }

    // 0-Many
    // public List<CropAssignment> CropAssignments { get; set; }
  }
}
