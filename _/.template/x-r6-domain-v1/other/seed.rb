{{camelU settings.Model}} {{#each rows}}{{snake this.name}}: '{{snake this.name}}'{{#if @last}}{{else}}, {{/if}}{{/each}}