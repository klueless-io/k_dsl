# rails generate model {{camelU settings.Model}} {{#each rows}}{{#ifx this.db_type '==' 'primarykey'}}{{else}}{{snake this.name}}:{{this.db_type}} {{/ifx}}{{/each}} --no-test-framework
class Create{{camelU settings.Models}} < ActiveRecord::Migration[5.2]
  def change
    create_table :{{snake settings.Models}} do |t|
{{#each rows_fields_and_fk}}
{{#ifx this.db_type '==' 'references'}}
      t.{{this.db_type}} :{{snake this.reference_table}}, foreign_key: true
{{else}}
      t.{{this.db_type}} :{{snake this.name}}
{{/ifx}}
{{/each}}

      t.timestamps
    end
  end
end
