# ---------------------------------------------
# Factory for {{camelU settings.Models}}
# ---------------------------------------------
FactoryBot.define do

    # Test data creation helpers can be found here: spec/helpers/td/td_{{snake settings.Model}}.rb
    factory :{{snake settings.Model}} do

      trait :{{snake settings.TdKey1}} do
{{#each rows}}
        {{#ifx this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: 'A - {{this.name}}' } }
        {{else ifx this.type '==' 'String'}}
{{#includes ../../../settings.ModelType (array 'AdminUser' 'BasicUser')}}
        {{snake this.name}} { '{{snake ../../../../settings.TdKey1}}@email.com' }
        password { 'password' }
{{else ifx this.name '==' ../../../../settings.MainKey}}
        {{snake this.name}} { '{{snake ../../../../../settings.TdKey1}}' }
{{else}}
        {{snake this.name}} { 'A - {{this.name}}' }
{{/includes}}
        {{else ifx this.type '==' 'Integer'}}
        {{snake this.name}} { 1111 }
        {{else ifx this.type '==' 'Float'}}
        {{snake this.name}} { 1.1 }
        {{else ifx this.type '==' 'Boolean'}}
        {{snake this.name}} { true }
        {{else ifx this.type '==' 'Date'}}
        {{snake this.name}} { Date.parse '01 Jan 2017' }
        {{else ifx this.type '==' 'DateTime'}}
        {{snake this.name}} { Date.parse '01 Jan 2017' }
  {{/ifx}}
  {{/each}}
      end

      trait :{{snake settings.TdKey2}} do
{{#each rows}}
        {{#ifx this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: 'B - {{this.name}}' } }
        {{else ifx this.type '==' 'String'}}
{{#includes ../../../settings.ModelType (array 'AdminUser' 'BasicUser')}}
        {{snake this.name}} { '{{snake ../../../../settings.TdKey2}}@email.com' }
        password { 'password' }
{{else ifx this.name '==' ../../../../settings.MainKey}}
        {{snake this.name}} { '{{snake ../../../../../settings.TdKey2}}' }
{{else}}
        {{snake this.name}} { 'B - {{this.name}}' }
{{/includes}}
        {{else ifx this.type '==' 'Integer'}}
        {{snake this.name}} { 2222 }
        {{else ifx this.type '==' 'Float'}}
        {{snake this.name}} { 2.2 }
        {{else ifx this.type '==' 'Boolean'}}
        {{snake this.name}} { false }
        {{else ifx this.type '==' 'Date'}}
        {{snake this.name}} { Date.parse '01 Feb 2017' }
        {{else ifx this.type '==' 'DateTime'}}
        {{snake this.name}} { Date.parse '01 Feb 2017' }
{{/ifx}}
{{/each}}
      end

      trait :{{snake settings.TdKey3}} do
{{#each rows}}
        {{#ifx this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: 'C - {{this.name}}' } }
        {{else ifx this.type '==' 'String'}}
{{#includes ../../../settings.ModelType (array 'AdminUser' 'BasicUser')}}
        {{snake this.name}} { '{{snake ../../../../settings.TdKey3}}@email.com' }
        password { 'password' }
{{else ifx this.name '==' ../../../../settings.MainKey}}
        {{snake this.name}} { '{{snake ../../../../../settings.TdKey3}}' }
{{else}}
        {{snake this.name}} { 'C - {{this.name}}' }
{{/includes}}
        {{else ifx this.type '==' 'Integer'}}
        {{snake this.name}} { 3333 }
        {{else ifx this.type '==' 'Float'}}
        {{snake this.name}} { 3.3 }
        {{else ifx this.type '==' 'Boolean'}}
        {{snake this.name}} { true }
        {{else ifx this.type '==' 'Date'}}
        {{snake this.name}} { Date.parse '01 March 2017' }
        {{else ifx this.type '==' 'DateTime'}}
        {{snake this.name}} { Date.parse '01 March 2017' }
{{/ifx}}
{{/each}}
      end
        
      # ---------------------------------------------
      # Factory for {{camelU settings.Models}} QUERY/Filter operations
      # ---------------------------------------------
  
      # Example Data Printout
  
      # ---------------------------------------------
  {{#each settings.TdQuery}}
      trait :query_{{snake ../settings.Model}}_{{.}} do
  {{#each ../rows}}
        {{#ifx this.db_type '==' 'jsonb'}}
        {{snake this.name}} {  { a: '{{this.name}}' } }
        {{else ifx this.type '==' 'String'}}
        {{snake this.name}} { '{{snake this.name}}_{{../../../.}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}' }
            {{#includes ../../../../settings.ModelType (array 'AdminUser' 'BasicUser')}}
        password { 'password' }
            {{/includes}}
        {{else ifx this.type '==' 'Integer'}}
        {{snake this.name}} { 1{{../../../../.}} }
        {{else ifx this.type '==' 'Float'}}
        {{snake this.name}} { 1{{../../../../../.}}.1 }
        {{else ifx this.type '==' 'Boolean'}}
        {{snake this.name}} { {{tdd_boolean @../index}} }
        {{else ifx this.type '==' 'Date'}}
        {{snake this.name}} { Date.parse '{{../../../../../../../.}} Jan 2017' }
        {{else ifx this.type '==' 'DateTime'}}
        {{snake this.name}} { Date.parse '{{../../../../../../../../.}} Jan 2017' }
  {{/ifx}}
  {{/each}}
      end
  
  {{/each}}
  
    end
  
  end