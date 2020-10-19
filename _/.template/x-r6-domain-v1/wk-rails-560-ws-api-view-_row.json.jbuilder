{{#each rows}}
{{#ifx this.type '==' 'ForeignKey'}}
json.{{snake this.name}}_id row.{{snake this.name}}_id
{{else}}
json.{{snake this.name}} row.{{snake this.name}}
{{/ifx}}
{{/each}}

# json.created_at row.created_at
# json.updated_at row.updated_at
