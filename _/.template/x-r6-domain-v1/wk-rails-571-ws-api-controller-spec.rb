require 'rails_helper'
require 'spec_helper'

# {{camelU settings.Models}}Controller :: Restful tests
RSpec.describe Api::V1::{{camelU settings.Models}}Controller, type: :controller do
  render_views

  before(:each) do
    FactoryBot.reload

    @request.env['HTTP_ACCEPT'] = 'application/json'
    # @request.env['CONTENT_TYPE'] = 'application/json'
  end


  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context 'factories' do

    before(:each) do
      full_data_set
    end

    describe 'check factory data' do

      it 'should print test data' do
      
        print_data_set
      
        expect(1).to eq(1)
      end                             if AppService::SHOULD_PRINT_TEST_DATA

      it 'should have test data' do

        # Note: This is copied from /spec/models/{{snake settings.Model}}_spec.rb and so may be better placed in a helper such as /spec/helpers/{{snake settings.Model}}_expect.rb
        expect({{camelU settings.Model}}.count).to eql 3

        expect(@{{snake settings.Model}}_{{snake settings.TdKey1}}).to_not be_nil
        expect(@{{snake settings.Model}}_{{snake settings.TdKey2}}).to_not be_nil
      end

    end

  end

  # ----------------------------------------------------------------------
  # {{camelU settings.Models}}Controller.show
  #
  # GET api/v1/{{snake settings.Models}}/:id
  # ----------------------------------------------------------------------

  context 'show' do

    before(:each) do
      full_data_set
    end

    it 'should have success response and data for valid ID' do
      get :show, params: { id: @{{snake settings.Model}}_{{snake settings.TdKey1}}.id }

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil

      {{#each rows}}
      {{#ifx this.type '==' 'ForeignKey'}}
      expect(data.row.{{snake this.name}}_id).to eq(@{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}}_id)
      {{else}}
      expect(data.row.{{snake this.name}}).to eq(@{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}})
{{/ifx}}
      {{/each}}
    end

    it 'should have failure response for invalid ID' do
      get :show, params: { id: '3' }

      # L.info response.body.parse_json

      expect(response.status).to eq(404)

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
      expect(data.result.message).to_not be_empty
      expect(data.row).to be_nil


      get :show, params: { id: 'bad_name' }
      expect(response.status).to eq(404)

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
    end

  end

  # ----------------------------------------------------------------------
  # {{camelU settings.Models}}Controller.index (Query)
  # 
  # Note: Additional data tests can be found in {{snake settings.Model}}_query_spec
  #
  # GET api/v1/{{snake settings.Models}}?options={}
  # ----------------------------------------------------------------------

  context 'index' do

    before(:each) do
      full_data_set_for_query
    end

    it 'should query {{camelU settings.Model}} and return first page of data for no filter conditions' do
      get :index

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_index

      expect(data.result.success).to eq(true)

      expect(data.page).to_not be_nil
      expect(data.rows).to_not be_nil

      expect(data.page.no).to eq(1)
      expect(data.page.size).to eq(20)
      expect(data.page.total).to eq({{camelU settings.Model}}.count)

      {{#each rows}}
      {{#ifx this.type '==' 'ForeignKey'}}
      expect(data.rows.first.{{snake this.name}}_id).to eq(@query_{{snake ../settings.Model}}_01.{{snake this.name}}_id)
      {{else}}
      expect(data.rows.first.{{snake this.name}}).to eq(@query_{{snake ../settings.Model}}_01.{{snake this.name}})
{{/ifx}}
      {{/each}}

      {{#each rows}}
      {{/each}}
    end

    it 'should query {{camelU settings.Model}} with custom filter and sort order' do

      ids = [
        @query_{{snake settings.Model}}_01.id,
        @query_{{snake settings.Model}}_03.id,
        @query_{{snake settings.Model}}_10.id
      ].join(',')

      get :index, params: { options: '{"filter":{"id":"' + ids + '"},"sort":[{"field":"{{snake settings.key.value}}","sort":"desc"}]}' }

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_index

      expect(data.result.success).to eq(true)

      expect(data.page).to_not be_nil
      expect(data.rows).to_not be_nil

      expect(data.page.no).to eq(1)
      expect(data.page.size).to eq(20)
      expect(data.page.total).to eq(data.rows.length)

      # Descending order
      expect(data.rows.map(&:id)).to include(
        @query_{{snake settings.Model}}_01.id,
        @query_{{snake settings.Model}}_03.id,
        @query_{{snake settings.Model}}_10.id)

      expect(data.rows[0].{{snake settings.key.value}}).to eq(@query_{{snake settings.Model}}_10.{{snake settings.key.value}})
      expect(data.rows[1].{{snake settings.key.value}}).to eq(@query_{{snake settings.Model}}_03.{{snake settings.key.value}})
      expect(data.rows[2].{{snake settings.key.value}}).to eq(@query_{{snake settings.Model}}_01.{{snake settings.key.value}})
    end

    it 'should query {{camelU settings.Model}} with custom pagination' do
      get :index, params: { options: '{"page":{"active":true,"no":2,"size":3}}' }

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_index

      expect(data.result.success).to eq(true)

      expect(data.page).to_not be_nil
      expect(data.rows).to_not be_nil

      expect(data.page.no).to eq(2)
      expect(data.page.size).to eq(3)
      expect(data.page.total).to eq(data.rows.length)

      # Page 2 data
      expect(data.rows[0].{{snake settings.key.value}}).to eq(@query_{{snake ./settings.Model}}_04.{{snake settings.key.value}})
      expect(data.rows[1].{{snake settings.key.value}}).to eq(@query_{{snake ./settings.Model}}_10.{{snake settings.key.value}})
      expect(data.rows[2].{{snake settings.key.value}}).to eq(@query_{{snake ./settings.Model}}_11.{{snake settings.key.value}})
    end

  end

  # ----------------------------------------------------------------------
  # Create {{camelU settings.Model}}
  #
  # POST api/v1/{{snake settings.Models}}
  # ----------------------------------------------------------------------

  context 'create' do

    before(:each) do
      data_set_for_create
    end

    it 'should create {{titleize (humanize settings.Model)}}' do

      expected_count = {{camelU settings.Model}}.count + 1

      # Set Field Values
      new_row = {
{{#each relations_one_to_one}}
        {{snake this.field}}: @{{snake this.name}}_{{snake this.td_key1}}.id,
{{/each}}
{{#each rows_fields_and_virtual}}
      {{#ifx this.db_type '==' 'jsonb'}}
        {{snake this.name}}: { a: '{{snake this.name}}'}{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Integer'}}
        {{snake this.name}}: 1{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Boolean'}}
        {{snake this.name}}: true{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Float'}}
        {{snake this.name}}: 1.1{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'Date'}}
        {{snake this.name}}: DateTime.now{{#if @last}}{{else}},{{/if}}
      {{else ifx this.type '==' 'DateTime'}}
        {{snake this.name}}: DateTime.now{{#if @last}}{{else}},{{/if}}
      {{else}}
        {{snake this.name}}: '{{snake this.name}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}'{{#if @last}}{{else}},{{/if}}
{{/ifx}}
{{/each}}
      }


      # Set any relations here

      # Create a new {{snake settings.Model}} through controller action
      post :create, params: { {{snake settings.Model}}: new_row }

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      # Check {{snake settings.Model}} was created
      expect({{camelU settings.Model}}.count).to eq(expected_count)

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil

      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      expect(data.row.{{snake this.name}}).to eq({"a"=>"{{snake this.name}}"})
      {{else ifx this.type '==' 'Integer'}}
      expect(data.row.{{snake this.name}}).to eq(1)
      {{else ifx this.type '==' 'Boolean'}}
      expect(data.row.{{snake this.name}}).to eq(true)
      {{else ifx this.type '==' 'Float'}}
      expect(data.row.{{snake this.name}}).to eq(1.1)
      {{else ifx this.type '==' 'Date'}}
      expect(data.row.{{snake this.name}}).to be_within(1.second).of(DateTime.now) # This really needs to be near to second, refactor and update template
      {{else ifx this.type '==' 'DateTime'}}
      expect(data.row.{{snake this.name}}).to be_within(1.second).of(DateTime.now) # This really needs to be near to second, refactor and update template
      {{else}}
      expect(data.row.{{snake this.name}}).to eq('{{snake this.name}}{{#ifx this.format_type '==' 'email'}}@email.com{{/ifx}}')
{{/ifx}}
      {{/each}}
    end

    it 'should fail to create {{titleize (humanize settings.Model)}} when required fields have invalid data' do

      expect({{camelU settings.Model}}.count).to eq(0)

      new_row = {
      {{#each rows}}
      {{#ifx this.type '==' 'PrimaryKey'}}
      {{else ifx this.type '==' 'ForeignKey'}}
      {{else}}
        {{snake this.name}}: nil{{#if @last}}{{else}},{{/if}}
{{/ifx}}
      {{/each}}
      }

      # Set any relations here

      # Try to create a new {{snake settings.Model}} through this controller action
      post :create, params: { {{snake settings.Model}}: new_row }

      # L.info response.body.parse_json

      expect(response.status).to eq(404)

      expect({{camelU settings.Model}}.count).to eq(0)

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
      expect(data.row).to be_nil

      # puts response.body

      # Check Field Validation
      {{#each rows_fields_and_virtual}}
      {{#ifx this.type '==' 'Boolean'}}
      expect(data.result.errors).to include("{{humanize this.name}} must be provided")
      {{else ifx this.db_type '==' 'jsonb'}}
      # Note: 
      # {{humanize this.name}} = nil converts to {{humanize this.name}} = ''
      # This means both blank and invalid json errors will be triggered
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
      expect(data.result.errors).to include("{{humanize this.name}} is not valid json")
      {{else}}
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
{{/ifx}}
      {{/each}}

      # Check Relations
      {{#each relations_one_to_one}}
      {{#ifx this.json.optional '==' true}}
      {{else}}
      expect(data.result.errors).to include("{{humanize this.name}} must exist")
{{/ifx}}
{{/each}}
      
      # Check Field + Relation Count
      expect(data.result.errors.count).to eq({{settings.stats.fields_and_virtual_error_message_count}} + {{relations_one_to_one.length}})

      # p_{{snake settings.Models}}
    end

  end

  # ----------------------------------------------------------------------
  # Update {{camelU settings.Model}}
  #
  # PUT api/v1/{{snake settings.Models}}/:id
  # ----------------------------------------------------------------------
  context 'update' do

    before(:each) do
      full_data_set
    end

    it 'should update {{titleize (humanize settings.Model)}}' do

      # Update Fields
      {{#each rows_fields}}
      {{#ifx this.db_type '==' 'jsonb'}}
      exp_{{snake this.name}} = @{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}}
      exp_{{snake this.name}}['a'] = 'update {{snake this.name}}'
      {{else ifx this.type '==' 'Boolean'}}
      exp_{{snake this.name}} = !@{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}}
      {{else ifx this.type '==' 'String'}}
      exp_{{snake this.name}} = @{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}} + '+updated'
      {{else ifx this.type '==' 'Integer'}}
      exp_{{snake this.name}} = @{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}} + 1
      {{else ifx this.type '==' 'Float'}}
      exp_{{snake this.name}} = @{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}} + 1
      {{else ifx this.type '==' 'Date'}}
      exp_{{snake this.name}} = @{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}} + 1.days
      {{else ifx this.type '==' 'DateTime'}}
      exp_{{snake this.name}} = @{{snake ../settings.Model}}_{{snake ../settings.TdKey1}}.{{snake this.name}} + 1.days
      {{else}}
      #exp_{{snake ../settings.Model}}.{{snake this.name}} = '{{snake this.name}}' # Custom type
{{/ifx}}
      {{/each}}

      update_row = {
      {{#each rows_fields}}
        {{snake this.name}}: exp_{{snake this.name}}{{#if @last}}{{else}},{{/if}}
      {{/each}}
      }

      # Set any relations here

      # Update existing {{snake settings.Model}} through controller update action
      post :update, params: { id: @{{snake settings.Model}}_{{snake settings.TdKey1}}.id, {{snake settings.Model}}: update_row }

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil

      {{#each rows_fields}}
      expect(data.row.{{snake this.name}}).to eq(exp_{{snake this.name}})
      {{/each}}

      # Check any relations here

      # p_{{snake settings.Models}}
    end

    it 'should fail to update {{titleize (humanize settings.Model)}} when required fields have invalid data' do

      update_row = {
      {{#each rows_fields}}
        {{snake this.name}}: nil{{#if @last}}{{else}},{{/if}}
      {{/each}}
      }

      # Try to update existing {{snake settings.Model}} through controller action
      post :update, params: { id: @{{snake settings.Model}}_{{snake settings.TdKey1}}.id, {{snake settings.Model}}: update_row }

      # L.info response.body.parse_json

      expect(response.status).to eq(404)

      # puts response.body

      data = parse_result_with_row

      expect(data.result.success).to eq(false)
      expect(data.row).to be_nil

      # Check Field Validation
      {{#each rows}}
      {{#ifx this.type '==' 'PrimaryKey'}}
      {{else ifx this.type '==' 'ForeignKey'}}
      {{else ifx this.type '==' 'Boolean'}}
      expect(data.result.errors).to include("{{humanize this.name}} must be provided")
      {{else ifx this.db_type '==' 'jsonb'}}
      # Note: 
      # {{humanize this.name}} = nil converts to {{humanize this.name}} = ''
      # This means both blank and invalid json errors will be triggered
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
      expect(data.result.errors).to include("{{humanize this.name}} is not valid json")
      {{else}}
      expect(data.result.errors).to include("{{humanize this.name}} can't be blank")
{{/ifx}}
      {{/each}}

      expect(data.result.errors.count).to eq({{settings.stats.fields_error_message_count}})

      # p_{{snake settings.Models}}
    end

    # it 'should fail to update {{titleize (humanize settings.Model)}} when required relations are missing' do
    #
    #   {{snake settings.Model}} = {{camelU settings.Model}}.find(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)
    #
    #
    #   is_save = {{snake settings.Model}}.save
    #
    #   # L.block {{snake settings.Model}}.errors.full_messages
    #
    #   expect(is_save).to eq(false)
    #
    #   # Check Relations
    #
    #   expect({{snake settings.Model}}.errors.messages.count).to eq(1)
    #
    #   # p_{{snake settings.Models}}
    # end

  end

  # ----------------------------------------------------------------------
  # Delete {{camelU settings.Model}}
  #
  # DELETE api/v1/{{snake settings.Models}}/:id
  # ----------------------------------------------------------------------

  context 'destroy' do

    before(:each) do
      full_data_set
    end

    it 'should destroy {{titleize (humanize settings.Model)}} by id' do

      count = {{camelU settings.Model}}.count

      get :destroy, params: { id: @{{snake settings.Model}}_{{snake settings.TdKey1}}.id }

      # L.info response.body.parse_json

      expect(response.status).to eq(200)

      data = parse_result_with_row

      expect(data.result.success).to eq(true)
      expect(data.row).to_not be_nil

      expect(data.row.id).to eq(@{{snake settings.Model}}_{{snake settings.TdKey1}}.id)

      expect({{camelU settings.Model}}.count).to eq(count-1)

      # p_{{snake settings.Models}}
    end

  end

  # ----------------------------------------------------------------------
  # Convert each API JSON string into structs objects with named properties
  # ----------------------------------------------------------------------

  def parse_result_with_row
    json = response.body.parse_json

    row = TestData::TdApi{{camelU settings.Model}}Row::map(json['row'])

    return TestData::TdApiOneRow.new({
      result: map_td_api_result(json['result']),
      row: row
    })
  end

  def parse_index
    json = response.body.parse_json

    rows = json['rows'].map { |row| TestData::TdApi{{camelU settings.Model}}Row::map(row) }

    return TestData::TdApiManyRows.new({
      result: map_td_api_result(json['result']),
      page: map_td_api_page(json['page']),
      rows: rows
    })
  end

  # ----------------------------------------------------------------------
  # Create unit test data
  # ----------------------------------------------------------------------

  # data set for create unit tests
  def data_set_for_create
{{#each settings.ParentDependencies}}
    td_{{snake this}}
{{/each}}
{{#each relations_one_to_one}}
    td_{{snake this.name_plural}}
{{/each}}
  end

  # data set for general unit tests
  def full_data_set
    data_set_for_create

    td_{{snake settings.Models}}
  end

  def full_data_set_for_query
    data_set_for_create

    td_{{snake settings.Models}}_for_query
  end

  def print_data_set
    return if !AppService::is_debug()
    
      {{#each settings.ParentDependencies}}
    p_{{snake this}}_as_table
      {{/each}}
{{#each relations_one_to_one}}
    p_{{snake this.name_plural}}_as_table
{{/each}}
    p_{{snake settings.Models}}_as_table
    #p_{{snake settings.Models}}(nil, 'detailed')
  end

end