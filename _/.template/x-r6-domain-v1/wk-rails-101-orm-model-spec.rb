# ----------------------------------------------------------------------
# {{camelU settings.Model}} :: CRUD and other model tests
# ----------------------------------------------------------------------

require 'rails_helper'
require 'spec_helper'

RSpec.describe {{camelU settings.Model}}, type: :model do

  before(:each) do
    FactoryBot.reload
  end

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context "factories" do

    before(:each) do
      full_data_set
    end

    describe 'check factory data' do

      it 'should print test data' do
        print_data_set
      
        expect(1).to eq(1)
      end                             if AppService::SHOULD_PRINT_TEST_DATA

      it 'should have test data' do

        # Note: This is copied from /spec/controllers/{{snake settings.Model}}_spec.rb and so may be better placed in a helper such as /spec/helpers/{{snake settings.Model}}_expect.rb
        expect({{camelU settings.Model}}.count).to eql 3

        expect(@{{snake settings.Model}}_{{snake settings.TdKey1}}).to_not be_nil
        expect(@{{snake settings.Model}}_{{snake settings.TdKey2}}).to_not be_nil
        expect(@{{snake settings.Model}}_{{snake settings.TdKey3}}).to_not be_nil
      end

    end

  end

  # ----------------------------------------------------------------------
  # Read {{camelU settings.Model}}
  # ----------------------------------------------------------------------

  context "read" do

    before(:each) do
      full_data_set
    end

    it "should show {{titleize (humanize settings.Model)}}" do

      {{snake settings.Model}} = {{camelU settings.Model}}.find(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)

      {{#each rows}}
      {{#ifx this.type '==' 'SomeCustomType'}}
      {{else}}
      expect({{snake ../settings.Model}}.{{snake this.name}}).to eq(@{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}})
      {{/ifx}}
      {{/each}}

      # Check Relations
{{#each relations_one_to_one}}
      expect({{snake ../settings.Model}}.{{snake this.name}}.id).to eq(@{{snake this.name}}_{{snake this.td_key1}}.id)
{{/each}}

      # p_{{snake settings.Models}}
    end

  end

  # ----------------------------------------------------------------------
  # Create {{camelU settings.Model}}
  # ----------------------------------------------------------------------

  context "create" do

    before(:each) do
      data_set_for_create
    end

    it "should create {{titleize (humanize settings.Model)}}" do

      expected_count = {{camelU settings.Model}}.count + 1

      new_row = {}

      # Set Field Values
      {{#each rows_fields_and_virtual}}
      {{#ifx this.db_type '==' 'jsonb'}}
      new_row[:{{snake this.name}}] = { a: '{{this.name}}' }
      {{else ifx this.type '==' 'Integer'}}
      new_row[:{{snake this.name}}] = 1
      {{else ifx this.type '==' 'Boolean'}}
      new_row[:{{snake this.name}}] = true
      {{else ifx this.type '==' 'Date'}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else ifx this.type '==' 'DateTime'}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else}}
      new_row[:{{snake this.name}}] = '{{snake this.name}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}'
{{/ifx}}
      {{/each}}

      # Set Relations
{{#each relations_one_to_one}}
      new_row[:{{snake this.name}}] = @{{snake this.name}}_{{snake this.td_key1}}
{{/each}}

      {{snake settings.Model}} = {{camelU settings.Model}}.new(new_row)

      is_save = {{snake settings.Model}}.save

      # L.block {{snake settings.Model}}.errors.full_messages

      expect(is_save).to eq(true)

      expect({{camelU settings.Model}}.count).to eq(expected_count)

      find_{{snake settings.Model}} = {{camelU settings.Model}}.find_by(id: {{snake settings.Model}}.id)

      # Expect Fields
      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      expect(find_{{snake ../settings.Model}}.{{snake this.name}}).to eq({ "a"=> "{{snake this.name}}" })
      {{else ifx this.type '==' 'Date'}}
      expect(find_{{snake ../settings.Model}}.{{snake this.name}}).to be_within(1.second).of({{snake ../settings.Model}}.{{snake this.name}})
      {{else ifx this.type '==' 'DateTime'}}
      expect(find_{{snake ../settings.Model}}.{{snake this.name}}).to be_within(1.second).of({{snake ../settings.Model}}.{{snake this.name}})
      {{else}}
      expect(find_{{snake ../settings.Model}}.{{snake this.name}}).to eq({{snake ../settings.Model}}.{{snake this.name}})
{{/ifx}}
      {{/each}}
      
      # Expect Relationships
{{#each relations_one_to_one}}
      expect({{snake ../settings.Model}}.{{snake this.name}}.id).to eq(@{{snake this.name}}_{{this.td_key1}}.id)
{{/each}}

      # p_{{snake settings.Models}}
    end

    it "should fail to create {{titleize (humanize settings.Model)}} when required fields are missing" do

      expected_count = {{camelU settings.Model}}.count

      new_row = {}

      # Set Field Values
      {{#each rows_fields_and_virtual}}
      new_row[:{{snake this.name}}] = nil
      {{/each}}
      # Set Relations
{{#each relations_one_to_one}}
      new_row[:{{snake this.name}}] = nil
{{/each}}

      {{snake settings.Model}} = {{camelU settings.Model}}.new(new_row)

      is_save = {{snake settings.Model}}.save

      # L.block {{snake settings.Model}}.errors.full_messages

      expect(is_save).to eq(false)

      expect({{camelU settings.Model}}.count).to eq(expected_count)

      # Check Field Validation
      {{#each rows_fields}}
      {{#ifx this.type '==' 'Boolean'}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} must be provided")
      {{else}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} can't be blank")
{{/ifx}}
      {{/each}}
{{#includes settings.ModelType (array 'AdminUser' 'BasicUser')}}
      expect({{snake settings.Model}}.errors.full_messages).to include("Password can't be blank")
{{/includes}}

      # Check Relations
      {{#each relations_one_to_one}}
      {{#ifx this.json.optional '==' true}}
      {{else}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} must exist")
{{/ifx}}
      {{/each}}

      # Check Field + Relation Count
      expect({{snake settings.Model}}.errors.messages.count).to eq({{rows_fields_and_virtual.length}} + {{relations_one_to_one.length}})

      # p_{{snake settings.Models}}
    end

{{#array_has_key_value rows 'db_type' 'jsonb'}}
    it "should fail to create {{titleize (humanize settings.Model)}} when JSON data is invalid" do

      expected_count = {{camelU settings.Model}}.count

      new_row = {}

      # Set Field Values
      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      new_row[:{{snake this.name}}] = "invalid JSON data here"
      {{else ifx this.type '==' 'Integer'}}
      new_row[:{{snake this.name}}] = 1
      {{else ifx this.type '==' 'Boolean'}}
      new_row[:{{snake this.name}}] = true
      {{else ifx this.type '==' 'Date'}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else ifx this.type '==' 'DateTime'}}
      new_row[:{{snake this.name}}] = DateTime.now
      {{else}}
      new_row[:{{snake this.name}}] = '{{snake this.name}}'
{{/ifx}}
      {{/each}}

      # Set Relations
      {{#each relations}}
      {{#ifx this.type '==' 'OneToOne'}}
      new_row['{{snake this.name}}'] = @{{snake this.name}}_{{snake this.td_key1}}
{{/ifx}}
      {{/each}}

      {{snake settings.Model}} = {{camelU settings.Model}}.new(new_row)

      is_save = {{snake settings.Model}}.save

      # L.block {{snake settings.Model}}.errors.full_messages

      expect(is_save).to eq(false)

      # Check Field Validation
      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} is not valid json")
{{/ifx}}
      {{/each}}

      # p_{{snake settings.Models}}
    end
{{/array_has_key_value}}

  end

  # ----------------------------------------------------------------------
  # Update {{camelU settings.Model}}
  # ----------------------------------------------------------------------

  context "update" do

    before(:each) do
      full_data_set
    end

    it "should update {{titleize (humanize settings.Model)}}" do

      {{snake settings.Model}} = {{camelU settings.Model}}.find(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)

      # Update Fields
      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      {{snake ../settings.Model}}.{{snake this.name}} = { a: '{{this.name}}' }
      {{else ifx this.type '==' 'Boolean'}}
      {{snake ../settings.Model}}.{{snake this.name}} = false
      {{else ifx this.type '==' 'String'}}
      {{snake ../settings.Model}}.{{snake this.name}} = '{{snake this.name}}+updated{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}'
      {{else ifx this.type '==' 'Integer'}}
      {{snake ../settings.Model}}.{{snake this.name}} = 99999
      {{else}}
      #{{snake ../settings.Model}}.{{snake this.name}} = '{{snake this.name}}' # Custom type
{{/ifx}}
      {{/each}}

      # Update Relations
{{#each relations_one_to_one}}
      {{snake ../settings.Model}}.{{snake this.name}} = @{{snake name}}_{{this.td_key1}}
{{/each}}

      is_save = {{snake settings.Model}}.save

      # L.block {{snake settings.Model}}.errors.full_messages

      expect(is_save).to eq(true)

      # Expect Fields
      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      expect({{snake ../settings.Model}}.{{snake this.name}}).to eq({ "a"=> "{{snake this.name}}" })
      {{else ifx this.type '==' 'Boolean'}}
      expect({{snake ../settings.Model}}.{{snake this.name}}).to be_falsey
      {{else ifx this.type '==' 'String'}}
      expect({{snake ../settings.Model}}.{{snake this.name}}).to eq('{{snake this.name}}+updated{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}')
      {{else ifx this.type '==' 'Integer'}}
      expect({{snake ../settings.Model}}.{{snake this.name}}).to eq(99999)
      {{else}}
      #expect({{snake ../settings.Model}}.{{snake this.name}}).to eq('{{snake this.name}}') # Custom type
{{/ifx}}
      {{/each}}

      # Expect Relationships
{{#each relations_one_to_one}}
      #expect({{snake ../settings.Model}}.{{snake this.name}}.id).to eq(@{{snake name}}_{{snake settings.TdKey1}}.id)
{{/each}}

      # p_{{snake settings.Models}}
    end

    it "should fail to update {{titleize (humanize settings.Model)}} when required fields are missing" do

      {{snake settings.Model}} = {{camelU settings.Model}}.find(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)

      {{#each rows_fields}}
      {{snake ../settings.Model}}.{{snake this.name}} = nil
      {{/each}}

      is_save = {{snake settings.Model}}.save

      # L.block {{snake settings.Model}}.errors.full_messages

      expect(is_save).to eq(false)

      # Check Field Validation
      {{#each rows_fields}}
      {{#ifx this.type '==' 'Boolean'}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} must be provided")
      {{else}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} can't be blank")
{{/ifx}}
      {{/each}}

      expect({{snake settings.Model}}.errors.messages.count).to eq({{rows_fields.length}})

      # p_{{snake settings.Models}}
    end
    
{{#if relations_one_to_one}}
    it "should fail to update {{titleize (humanize settings.Model)}} when required relations are missing" do

      {{snake settings.Model}} = {{camelU settings.Model}}.find(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)

{{#each relations_one_to_one}}
      {{snake ../settings.Model}}.{{snake this.name}} = nil
{{/each}}

      is_save = {{snake settings.Model}}.save

      # L.block {{snake settings.Model}}.errors.full_messages

      expect(is_save).to eq(false)

      # Check Relations
{{#each relations_one_to_one}}
{{#ifx this.json.optional '==' true}}
      # How would you like to deal with this optional relation?
      # expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} must exist")
{{else}}
      expect({{snake ../settings.Model}}.errors.full_messages).to include("{{humanize this.name}} must exist")
{{/ifx}}
{{/each}}

      expect({{snake settings.Model}}.errors.messages.count).to eq({{relations_one_to_one.length}})

      # p_{{snake settings.Models}}
    end
{{/if}}

  end

  # ----------------------------------------------------------------------
  # Delete {{camelU settings.Model}}
  # ----------------------------------------------------------------------

  context "delete" do

    before(:each) do
      full_data_set
    end

    it "should delete {{titleize (humanize settings.Model)}} by id" do

      count = {{camelU settings.Model}}.count

      {{camelU settings.Model}}.destroy(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)

      expect({{camelU settings.Model}}.count).to eq(count-1)

      # p_{{snake settings.Models}}
    end

    it "should delete {{titleize (humanize settings.Model)}} by multiple ids" do

      count = {{camelU settings.Model}}.count

      {{camelU settings.Model}}.where(id: [@{{snake settings.Model}}_{{snake settings.TdKey1}}.id, @{{snake settings.Model}}_{{snake settings.TdKey2}}.id]).destroy_all()

      expect({{camelU settings.Model}}.count).to eql (count-2)

      # p_{{snake settings.Models}}
    end

  end

  # data set for create unit tests
  def data_set_for_create
# {{#if settings.ParentDependencies}}
#     # Create higher level parent test data
# {{/if}}
# {{#each settings.ParentDependencies}}
#     td_{{snake this}}
# {{/each}}
# {{#if relations_one_to_one}}
#     # create one to one related test data
# {{/if}}
# {{#each relations_one_to_one}}
#     td_{{snake this.name_plural}}
# {{/each}}

  end

  # data set for general unit tests
  def full_data_set
    data_set_for_create
    
    @{{snake settings.Model}}_{{snake settings.TdKey1}} = FactoryBot.create(:{{snake settings.Model}}, :{{snake settings.TdKey1}}{{#if relations}}{{#each relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key1}}{{/ifx}}{{/each}}{{/if}})
    @{{snake settings.Model}}_{{snake settings.TdKey2}} = FactoryBot.create(:{{snake settings.Model}}, :{{snake settings.TdKey2}}{{#if relations}}{{#each relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key2}}{{/ifx}}{{/each}}{{/if}})
    @{{snake settings.Model}}_{{snake settings.TdKey3}} = FactoryBot.create(:{{snake settings.Model}}, :{{snake settings.TdKey3}}{{#if relations}}{{#each relations}}{{#ifx this.type '==' 'OneToOne'}}, {{this.name}}: @{{this.name}}_{{snake td_key3}}{{/ifx}}{{/each}}{{/if}})


    # td_{{snake settings.Models}}
  end
  


  def print_data_set
    return if !AppService::is_debug()
    
    {{#if settings.ParentDependencies}}
    # Print higher level parents
    {{/if}}
    {{#each settings.ParentDependencies}}
    p_{{snake this}}_as_table
    {{/each}}
    {{#if relations}}
    # Print related tables
    {{/if}}
{{#each relations}}
    p_{{snake this.name_plural}}_as_table
{{/each}}
    p_{{snake settings.Models}}_as_table
    #p_{{snake settings.Models}}(nil, 'detailed')
  end

end
