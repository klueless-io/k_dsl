module TestData

  # ---------------------------------------------
  # Setup Test Data for {{camelU settings.Models}}
  # ---------------------------------------------

  # Factories can be found here: spec/factories/{{snake settings.Models}}.rb

  # Test data for CRUD (Model/Controller) tests or specific business use cases
  def td_{{snake settings.Models}}

    @{{snake settings.Model}}_{{snake settings.TdKey1}} = FactoryBot.create(:{{snake settings.Model}}, :{{snake settings.TdKey1}}{{#if relations}}{{#each relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key1}}{{/ifx}}{{/each}}{{/if}})
    @{{snake settings.Model}}_{{snake settings.TdKey2}} = FactoryBot.create(:{{snake settings.Model}}, :{{snake settings.TdKey2}}{{#if relations}}{{#each relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key2}}{{/ifx}}{{/each}}{{/if}})
    @{{snake settings.Model}}_{{snake settings.TdKey3}} = FactoryBot.create(:{{snake settings.Model}}, :{{snake settings.TdKey3}}{{#if relations}}{{#each relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key3}}{{/ifx}}{{/each}}{{/if}})

  end

  # Test data for QUERY/Filter operations
  def td_{{snake settings.Models}}_for_query

{{#each settings.TdQuery}}
    @query_{{snake ../settings.Model}}_{{.}} = FactoryBot.create(:{{snake ../settings.Model}}, :query_{{snake ../settings.Model}}_{{.}}{{#if ../relations}}{{#each ../relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key1}}{{/ifx}}{{/each}}{{/if}})
{{/each}}

  end

end

