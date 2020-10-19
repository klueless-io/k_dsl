{{#*inline "one_to_one_association"}}
association :{{model}}{{#key}}, :{{../key}}{{/key}}
{{/inline}}
# ---------------------------------------------
# Factory for {{camelU settings.Models}}
# ---------------------------------------------
FactoryBot.define do

  # Test data creation helpers can be found here: spec/helpers/td/td_{{snake settings.Model}}.rb
  factory :{{snake settings.Model}} do

    initialize_with { {{camelU settings.Model}}.find_or_create_by({{snake settings.MainKey}}: {{snake settings.MainKey}}) }

{{#relations_one_to_one}}
    {{> one_to_one_association model=name}}
{{/relations_one_to_one}}

{{#includes settings.ModelType (array 'AdminUser' 'BasicUser')}}
    email { 'person@email.com' }
    password { 'password' }
{{else}}
{{#each rows}}
    {{> make_trait_key_value row=. settings=settings td_key="" alpha="" num=9 bool=true}}
{{/each}}
{{/includes}}      
  
    # ---------------------------------------------
    # Traits for common use cases
    # ---------------------------------------------

{{#*inline "make_trait_key_value"}}
{{#ifx db_type '==' 'jsonb'}}
{{snake name}} {  { a: '{{alpha}}{{name}}' } }
{{else ifx this.name '==' settings.MainKey}}
{{snake this.name}} { '{{snake td_key}}' }
{{else ifx type '==' 'String'}}
{{snake name}} { '{{alpha}}{{name}}' }
{{else ifx type '==' 'Integer'}}
{{snake name}} { {{num}}{{num}}{{num}}{{num}} }
{{else ifx type '==' 'Float'}}
{{snake name}} { {{num}}.{{num}} }
{{else ifx type '==' 'Boolean'}}
{{snake name}} { {{bool}} }
{{else ifx type '==' 'Date'}}
{{snake this.name}} { Date.parse '0{{num}} Jan 2017' }
{{else ifx this.type '==' 'DateTime'}}
{{snake this.name}} { Date.parse '0{{num}} Jan 2017' }
{{/ifx}}
{{/inline}}
{{#*inline "make_trait"}}
    trait :{{snake td_key}} do
{{#relations_one_to_one}}
      {{> one_to_one_association model=name key=(lookup . ../child_key) }}
{{/relations_one_to_one}}

{{#includes settings.ModelType (array 'AdminUser' 'BasicUser')}}
      email { '{{snake td_key}}@email.com' }
      password { 'password' }
{{else}}
{{#each rows}}
      {{> make_trait_key_value row=. settings=../settings td_key=../td_key alpha=../alpha num=../num bool=../bool}}
{{/each}}
{{/includes}}      
    end
  
{{/inline}}
{{> make_trait rows=rows settings=settings td_key=settings.TdKey1 alpha="A - " num=1 bool=true  child_key='td_key1'}}
{{> make_trait rows=rows settings=settings td_key=settings.TdKey2 alpha="B - " num=2 bool=false child_key='td_key2'}}
{{> make_trait rows=rows settings=settings td_key=settings.TdKey3 alpha="C - " num=3 bool=true  child_key='td_key3'}}
        
    # ---------------------------------------------
    # Traits for {{camelU settings.Models}} QUERY/Filter operations
    # ---------------------------------------------

{{#each settings.TdQuery}}
    trait :query_{{snake ../settings.Model}}_{{.}} do
{{#each ../rows}}
{{#ifx this.db_type '==' 'jsonb'}}
      {{snake this.name}} {  { a: '{{this.name}}' } }
      {{else ifx this.type '==' 'String'}}
      {{snake this.name}} { '{{snake this.name}}_{{../.}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}' }
{{#includes ../../settings.ModelType (array 'AdminUser' 'BasicUser')}}
      password { 'password' }
{{/includes}}
      {{else ifx this.type '==' 'Integer'}}
      {{snake this.name}} { 1{{../.}} }
      {{else ifx this.type '==' 'Float'}}
      {{snake this.name}} { 1{{../.}}.1 }
      {{else ifx this.type '==' 'Boolean'}}
      {{snake this.name}} { {{tdd_boolean @../index}} }
      {{else ifx this.type '==' 'Date'}}
      {{snake this.name}} { Date.parse '{{../.}} Jan 2017' }
      {{else ifx this.type '==' 'DateTime'}}
      {{snake this.name}} { Date.parse '{{../.}} Jan 2017' }
{{/ifx}}
{{/each}}
    end

{{/each}}

  end

end