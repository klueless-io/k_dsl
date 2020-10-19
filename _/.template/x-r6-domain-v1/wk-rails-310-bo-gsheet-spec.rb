require 'rails_helper'
require 'spec_helper'

# Gs{{camelU settings.Model}}
#
# Plain Old Object for reading data from from Google Sheet for GsGnModel
describe Gsheet::Gs{{camelU settings.Model}} do

  before(:each) do
    FactoryBot.reload
  end

  # --------------------------------------------------------------------------------
  # {{camelU settings.Models}} Service - Some Context
  # --------------------------------------------------------------------------------

  context 'setup' do

    describe 'instantiate' do

      it 'should instantiate class' do
        expect(Gsheet::Gs{{camelU settings.Model}}.new()).to_not be_nil
      end

      it 'should instantiate class with type safe data' do
        model = Gsheet::Gs{{camelU settings.Model}}.new({
          sample_key: 'sample',
          sync_{{snake settings.MainKey}}: '{{snake settings.MainKey}}',
          {{#each relations_one_to_one}}
          sync_fk_{{this.name}}: '{{this.td_key1}}',
{{/each}}

        {{#each rows_and_virtual}}
        {{#ifx this.type '==' 'PrimaryKey'}}
          {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
        {{else ifx this.type '==' 'ForeignKey'}}
          {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
        {{else ifx this.type '==' 'Integer'}}
          {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
        {{else ifx this.type '==' 'Boolean'}}
          {{snake this.name}}: true{{#if @last}}{{else}},{{/if}}
        {{else ifx this.type '==' 'Date'}}
          {{snake this.name}}: DateTime.now{{#if @last}}{{else}},{{/if}}
        {{else}}
          {{snake this.name}}: '{{snake this.name}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}'{{#if @last}}{{else}},{{/if}}
{{/ifx}}
            {{/each}}
        })

        # Keys
        expect(model.sample_key).to eq('sample')
        {{#each relations_one_to_one}}
        expect(model.sync_fk_{{this.name}}).to eq('{{this.td_key1}}')
{{/each}}
        expect(model.sync_{{snake settings.MainKey}}).to eq('{{snake settings.MainKey}}')

      # Model Data
      {{#each rows_and_virtual}}
      {{#ifx this.type '==' 'PrimaryKey'}}
        expect(model.{{snake this.name}}).to eq(1)
      {{else ifx this.type '==' 'ForeignKey'}}
        expect(model.{{snake this.name}}).to eq(1)
      {{else ifx this.type '==' 'Integer'}}
        expect(model.{{snake this.name}}).to eq(1)
      {{else ifx this.type '==' 'Boolean'}}
        expect(model.{{snake this.name}}).to eq(true)
      {{else ifx this.type '==' 'Date'}}
        expect(model.{{snake this.name}}).to eq(DateTime.now)
      {{else}}
        expect(model.{{snake this.name}}).to eq('{{snake this.name}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}')
{{/ifx}}
      {{/each}}

      end

    end

  end

end