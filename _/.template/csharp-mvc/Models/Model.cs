namespace {{#each blueprint.settings.application_namespace}}{{.}}{{#if @last}}{{else}}.{{/if}}{{/each}}
{
  using System.Collections.Generic;
  using System.ComponentModel.DataAnnotations.Schema;
  using Microsoft.EntityFrameworkCore;

  public partial class {{camel blueprint.settings.name}}
  {
  }
}
