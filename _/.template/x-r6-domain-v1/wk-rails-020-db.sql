-- ======================================================================
-- Common SQL statents for {{camelU settings.Models}}
-- ======================================================================

-- ----------------------------------------------------------------------
-- Select
-- ----------------------------------------------------------------------
select * from {{snake settings.Models}};

select count(*) from {{snake settings.Models}};

select 
{{#each rows_fields_and_pk}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}}
{{/each}}
{{#each relations_one_to_one}}
,  {{snake this.field}}
{{/each}}
from {{snake settings.Models}};

-- Join parents
{{#if relations}}
select 
{{#each rows_fields_and_pk}}
{{#if @first}}  {{else}}, {{/if}} {{snake ../settings.Models}}.{{snake this.name}}
{{/each}}
{{#each relations_one_to_one}}
,  {{snake this.field}}
,  {{snake this.name_plural}}.{{snake this.main_key}}
{{/each}}
from {{snake settings.Models}}
{{#each relations_one_to_one}}
join {{this.name_plural}} on {{this.name_plural}}.id = {{snake ../settings.Models}}.{{this.field}}
{{/each}}
;
{{/if}}

-- ----------------------------------------------------------------------
-- Insert
-- ----------------------------------------------------------------------
insert into {{snake settings.Models}} (
{{#each rows_fields}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}}
{{/each}}
{{#each relations_one_to_one}}
,  {{snake this.field}}
{{/each}}
, created_at
, updated_at
)
values (
{{#each rows_fields}}
{{#ifx this.type '==' 'ForeignKey'}}
{{#if @first}}  {{else}}, {{/if}} null                          -- Foreign KEY
{{else ifx this.type '==' 'Integer'}}
{{#if @first}}  {{else}}, {{/if}} 1
{{else ifx this.type '==' 'Boolean'}}
{{#if @first}}  {{else}}, {{/if}} true
{{else ifx this.type '==' 'Date'}}
{{#if @first}}  {{else}}, {{/if}} now()
{{else}}
{{#if @first}}  {{else}}, {{/if}} '{{snake this.name}}'
{{/ifx}}
{{/each}}
{{#each relations_one_to_one}}
,  null                          -- Put Foreign KEY for {{camelU this.field}} here
{{/each}}
, now()
, now()
);

-- ----------------------------------------------------------------------
-- Update
-- ----------------------------------------------------------------------
update {{snake settings.Models}}
set
{{#each rows_fields}}
{{#ifx this.type '==' 'Integer'}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}} = 1
{{else ifx this.type '==' 'Boolean'}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}} = true
{{else ifx this.type '==' 'Date'}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}} = now()
{{else}}
{{#if @first}}  {{else}}, {{/if}} {{snake this.name}} = '{{snake this.name}} - update'
{{/ifx}}
{{/each}}
{{#each relations_one_to_one}}
, {{snake this.field}} =  null                          -- Put Foreign KEY for updating {{camelU this.field}} here
{{/each}}
WHERE
  id = 1;

-- ----------------------------------------------------------------------
-- Delete
-- ----------------------------------------------------------------------

delete from {{snake settings.Models}};
alter sequence {{snake settings.Models}}_id_seq restart with 1;
