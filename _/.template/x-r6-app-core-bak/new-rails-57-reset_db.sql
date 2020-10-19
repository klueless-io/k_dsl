{{#each models}}
delete from {{snake this.names}};
alter sequence {{snake this.names}}_id_seq restart with 1;

{{/each}}
