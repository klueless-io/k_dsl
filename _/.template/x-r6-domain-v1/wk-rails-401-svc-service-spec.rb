require 'rails_helper'
require 'spec_helper'

# ----------------------------------------------------------------------
# {{camelU settings.Model}}Service
#
# Performs feature or domain specific business logic
#
# Tests can be light weight because much of the business logic is either
# light weight or delegated to other classes that have their own tests
# ----------------------------------------------------------------------
describe {{camelU settings.Model}}Service do

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

    describe 'print' do

      it 'should print test data' do
        print_data_set
      
        expect(1).to eq(1)
      end                             if AppService::SHOULD_PRINT_TEST_DATA

    end

  end

  # --------------------------------------------------------------------------------
  # {{camelU settings.Models}} Service - Some Context
  # --------------------------------------------------------------------------------

  context "some context, e.g. api" do

    before(:each) do
      FactoryBot.reload

      full_data_set
    end

    describe 'some sub group action' do

      it 'should do something' do

        expect({{camelU settings.Model}}.count).to be > 0

        result = {{camelU settings.Model}}Service.some_action

        expect(result).to eq('light weight action')
        # print_data_set
      end

    end

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
    {{#each relations}}
    {{#ifx this.type '==' 'OneToOne'}}
    td_{{snake this.name_plural}}
{{/ifx}}
{{/each}}
  end

  # data set for general unit tests
  def full_data_set
    data_set_for_create

    td_{{snake settings.Models}}
  end

  def full_data_set_for_query
    td_{{snake settings.Models}}_for_query
  end

  def print_data_set
    return if !AppService::is_debug()
    
    {{#each settings.ParentDependencies}}
    p_{{snake this}}_as_table
      {{/each}}
      {{#each relations}}
      {{#ifx this.type '==' 'OneToOne'}}
    p_{{snake this.name_plural}}_as_table
{{/ifx}}
      {{/each}}
    p_{{snake settings.Models}}_as_table
    #p_{{snake settings.Models}}(nil, 'detailed')
  end

end
