require 'rails_helper'
require 'spec_helper'

describe BulkUpsert::{{camelU settings.Model}}BulkUpsert do

  # NOTE: The tests on BASE must use a table and so they are using the {{camelU settings.Model}} as an example

  # Default bulk upsert
  #   - CANNOT destroy underlying table
  #   - Will automatically create constraining index
  subject(:upsert) { BulkUpsert::{{camelU settings.Model}}BulkUpsert.new() }

  before(:each) do
    FactoryBot.reload
  end

  # ----------------------------------------------------------------------
  # Examples of how you can use this in your code
  # ----------------------------------------------------------------------

  context 'examples', :gsheet_live_data do

    example 'synchronize {{dashify settings.Models}} from gsheets using [unit-test] data' do
      data_set_for_create

      upsert_{{snake settings.Models}} = BulkUpsert::{{camelU settings.Model}}BulkUpsert.new()
      upsert_{{snake settings.Models}}.destroy_and_resequence_table
      upsert_{{snake settings.Models}}.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')

      print_data_set
    end

    example 'synchronize {{dashify settings.Models}} from gsheets using [sample] data' do

{{#each settings.ParentDependencies}}
      upsert_{{snake this}} = BulkUpsert::{{camelU this}}BulkUpsert.new()
      upsert_{{snake this}}.destroy_and_resequence_table
      upsert_{{snake this}}.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'sample')
      
{{/each}}
{{#each relations_one_to_one}}
      upsert_{{snake this.name_plural}} = BulkUpsert::{{camelU this.name}}BulkUpsert.new()
      upsert_{{snake this.name_plural}}.destroy_and_resequence_table
      upsert_{{snake this.name_plural}}.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'sample')

{{/each}}
  
      upsert_{{snake settings.Models}} = BulkUpsert::{{camelU settings.Model}}BulkUpsert.new()
      upsert_{{snake settings.Models}}.destroy_and_resequence_table
      upsert_{{snake settings.Models}}.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'sample')

      print_data_set
    end

    example 'example: synchronize {{dashify settings.Models}} from gsheets using [production] data' do

{{#each settings.ParentDependencies}}
      upsert_{{snake this}} = BulkUpsert::{{camelU this}}BulkUpsert.new()
      upsert_{{snake this}}.destroy_and_resequence_table
      upsert_{{snake this}}.sync(source_key: 'production')

{{/each}}
{{#each relations_one_to_one}}
      upsert_{{snake this.name_plural}} = BulkUpsert::{{camelU this.name}}BulkUpsert.new()
      upsert_{{snake this.name_plural}}.destroy_and_resequence_table
      upsert_{{snake this.name_plural}}.sync(source_key: 'production')

{{/each}}
      upsert_{{snake settings.Models}} = BulkUpsert::{{camelU settings.Model}}BulkUpsert.new()
      upsert_{{snake settings.Models}}.destroy_and_resequence_table
      upsert_{{snake settings.Models}}.sync(source_key: 'production')

      print_data_set
    end

  end

  # ----------------------------------------------------------------------
  # Check/Debug factory data
  # ----------------------------------------------------------------------

  context "factories" do

    before(:each) do
      full_data_set
    end

    describe 'print' do

      # it 'should print test data' do
      #   print_data_set
      #
      #   expect(1).to eq(1)
      # end

    end

  end

  context "setup", :gsheet_test_data do

    it 'should instantiate the service' do
      expect(upsert).to_not be_nil
      # expect(upsert_with_destroy).to_not be_nil
    end

    it 'should have default properties' do

      expect_bulk_upsert_default_settings(
        upsert,
        table_name: '{{camelU settings.Model}}',
        table_name_plural: '{{snake settings.Models}}',
        can_destroy: true,
        single_use_unique_index: true,
        conflict_keys: ['{{snake settings.key.value}}']
     )
    end

  end

  context "reset table", :gsheet_test_data do

    before(:each) do
      full_data_set
    end

    it 'should destroy_and_resequence_table' do
      expect({{camelU settings.Model}}.count).to eq(3)

      # p_{{snake settings.Models}}_as_table

      upsert.destroy_and_resequence_table

      expect({{camelU settings.Model}}.count).to eq(0)

      td_{{snake settings.Models}}

      expect({{camelU settings.Model}}.order(:id).first.id).to eq(1)

      # p_{{snake settings.Models}}_as_table
    end

  end

  # context "create constraining indexes" do
  #
  # end

  context "synchronize", :gsheet_test_data do

    before(:each) do
      data_set_for_create
      # full_data_set
    end

    it 'should add {{snake settings.Models}}' do

      expect({{camelU settings.Model}}.count).to eq(0)

      upsert.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')

      expect({{camelU settings.Model}}.count).to eq(upsert.source_rows.length)

      # p_{{snake settings.Models}}_as_table
    end

    it 'should add new {{snake settings.Models}} only' do

      upsert.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')
      # p_{{snake settings.Models}}_as_table

      expect({{camelU settings.Model}}.count).to eq(upsert.source_rows.length)

      {{snake settings.Model}} = {{camelU settings.Model}}.first

{{#if settings.key.yes}}
      expected_{{snake settings.key.value}} = {{snake settings.Model}}.{{snake settings.key.value}}
{{/if}}
      {{snake settings.Model}}.delete

      expect({{camelU settings.Model}}.count).to eq(upsert.source_rows.length-1)

      upsert.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')
      # p_{{snake settings.Models}}_as_table

      expect({{camelU settings.Model}}.count).to eq(upsert.source_rows.length)
{{#ifx settings.no_key '==' false}}
      expect({{camelU settings.Model}}.order(:id).last.{{snake settings.key.value}}).to eq(expected_{{snake settings.key.value}})
{{/ifx}}

    end

{{#includes settings.ModelType (array 'AdminUser' 'BasicUser')}}
      # 'should update {{snake settings.Models}}'
      #   NOT SUPPORTED for {{settings.ModelType}}
      # end
{{else}}
    it 'should update {{snake settings.Models}}' do

      upsert.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')
      # p_{{snake settings.Models}}_as_table

      expect({{camelU settings.Model}}.count).to eq(upsert.source_rows.length)

      # Grab first and delete
      {{snake settings.Model}} = {{camelU settings.Model}}.first
      original_{{snake settings.utest_update.field_name}} = {{snake settings.Model}}.{{snake settings.utest_update.field_name}}

{{#ifx settings.utest_update.field_type '==' 'boolean'}}
      {{snake settings.Model}}.{{snake settings.utest_update.field_name}} = !{{snake settings.Model}}.{{snake settings.utest_update.field_name}}
{{else}}
      {{snake settings.Model}}.{{snake settings.utest_update.field_name}} = {{snake settings.Model}}.{{snake settings.utest_update.field_name}} + ' - updated'
{{/ifx}}
      {{snake settings.Model}}.save

      expect({{camelU settings.Model}}.first.{{snake settings.utest_update.field_name}}).to eq({{snake settings.Model}}.{{snake settings.utest_update.field_name}})

      # p_{{snake settings.Models}}_as_table
      upsert.sync(spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME_TEST, source_key: 'unit-test')
      # p_{{snake settings.Models}}_as_table

      expect({{camelU settings.Model}}.first.{{snake settings.utest_update.field_name}}).to eq(original_{{snake settings.utest_update.field_name}})

    end
{{/includes}}

  end


  # ----------------------------------------------------------------------
  # {{camelU settings.Models}}: Data Setup and Printing
  # ----------------------------------------------------------------------

  # NOTE: Refactor opportunity :: Test Data creation patterns are being
  #       repeated in services, controllers and model specs for the same
  #       table name and so these methods below should be moved out into
  #       a Test data helper section

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
