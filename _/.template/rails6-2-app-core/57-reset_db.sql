{{#each entities}}
delete from {{snake this.model_name_plural}};
alter sequence {{snake this.model_name_plural}}_id_seq restart with 1;

{{/each}}
