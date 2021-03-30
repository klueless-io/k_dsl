namespace {{app.application_namespace}}.Models
{
  using System;
  using System.Collections.Generic;

  public partial class {{camel entity.name}}
  {
    public int Id { get; set; }

    {{#if entity.columns}}
    // Common fields
    {{#each entity.columns}}
    public {{type}} {{camel name}} { get; set; }

    {{/each}}
    {{/if}}

    {{#if entity.relations_m1}}
    // 0-1 (Foreign Key relationships)
    {{#each entity.relations_m1}}
    public {{camel reference_type}} {{camel name}} { get; set; }
    
    {{/each}}
    {{/if}}

    {{#if entity.relations_1m}}
    // 1-Many relations
    {{#each entity.relations_1m}}
    public List<{{camel reference_type}}> {{camel name_plural}} { get; set; }

    {{/each}}
    {{/if}}
  }
}
