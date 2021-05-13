require 'rails_helper'
require 'spec_helper'

describe Query::{{camelU settings.Model}}Query do

  before(:each) do
    FactoryBot.reload
  end

  context 'factories' do

    before(:each) do
      full_data_set_for_query
    end

    it 'should print test data' do
      print_data_set
    
      expect(1).to eq(1)
    end                             if AppService::SHOULD_PRINT_TEST_DATA

    it 'should have test data' do
      expect({{camelU settings.Model}}.count).to be >= 2

      {{#each settings.TdQuery}}
      expect(@query_{{snake ../settings.Model}}_{{snake this}}).to_not be_nil
      {{/each}}

    end

  end

  context 'setup' do

    describe 'instantiate' do

      it 'should instantiate class' do
        expect(Query::{{camelU settings.Model}}Query.new({})).to_not be_nil
      end

    end

    describe 'configure' do

      it 'should have default configuration' do
        query = Query::{{camelU settings.Model}}Query.new({})

        expect(query.page.no).to eq(1)
        expect(query.page.size).to eq(20)
        expect(query.page.active).to eq(true)

        expect(query.filter).to eq({})
        expect(query.order_by).to eq([])

        # query.debug()

      end

      it 'should have a custom configuration' do
        config = <<-JSON
            {
              "page": {
                  "no": 1,
                  "size": 3
              },
              "filter": {
{{#ifx settings.no_key '==' true}}
{{else}}
                "search": "bob",
                "{{snake settings.MainKey}}s": ["bob", "jane"]
{{/ifx}}
              },
              "sort": [
{{#ifx settings.no_key '==' true}}
                { "field": "id" },  
{{else}}
                { "field": "{{snake settings.MainKey}}" },  
{{/ifx}}
                { "field": "created_at", "direction": "desc" }  
              ]
            }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)
        # query.debug()

        # expect(query.page.no).to eq(1)
        # expect(query.page.size).to eq(3)
        expect(query.page.active).to eq(true)

        # L.kv 'Filter', query.filter
        # L.kv 'Sort', query.sort

        expect(query.order_by.length).to eq(2)

{{#ifx settings.no_key '==' true}}
        expect(query.order_by[0].field).to eq('id')
        expect(query.order_by[0].direction).to eq('asc')
{{else}}
        expect(query.order_by[0].field).to eq('{{snake settings.MainKey}}')
        expect(query.order_by[0].direction).to eq('asc')
{{/ifx}}
          
        expect(query.order_by[1].field).to eq('created_at')
        expect(query.order_by[1].direction).to eq('desc')

{{#ifx settings.no_key '==' false}}
        expect(query.filter["search"]).to eq("bob")
        expect(query.filter["{{snake settings.MainKey}}s"]).to eq(["bob", "jane"])
{{/ifx}}

      end

    end

  end

  context 'queries' do

    before(:each) do
      full_data_set_for_query
    end

    describe 'all data' do

      it 'should query {{camelU settings.Model}} and return all rows' do

        config = <<-JSON
          {}
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run
        page = query.current_page()

        expect(page.no).to eq(1)
        expect(page.size).to eq(20)
        expect(page.total).to eq({{camelU settings.Model}}.count)

        expect(result.length).to eq({{camelU settings.Model}}.count)

        # p_{{snake settings.Models}}_as_table(result)
      end

    end

    describe 'pagination' do

      it 'should query {{camelU settings.Model}}s for page size 3: page #1' do

        config = <<-JSON
          {
            "page": {
                "no": 1,
                "size": 3
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run
        page = query.current_page()

        # p_{{snake settings.Models}}_as_table(result)

        expect(page.no).to eq(1)
        expect(page.size).to eq(3)
        expect(page.total).to eq(3)

        expect(result.length).to eq(page.total)

        # First record on the :first page
{{#ifx settings.no_key '==' true}}
        expect(result.first.id).to eq(@query_{{snake settings.Model}}_01.id)
{{else}}
        expect(result.first.{{snake settings.MainKey}}).to eq(@query_{{snake settings.Model}}_01.{{snake settings.MainKey}})
{{/ifx}}
      end

      it 'should query {{camelU settings.Model}} for page size 3: page #2' do

        config = <<-JSON
          {
            "page": {
              "no": 2,
              "size": 3
            },
            "sort": [
{{#ifx settings.no_key '==' true}}
              {
                "field": "id",
                "sort": "asc"
              }
{{else}}
              {
                "field": "{{snake settings.MainKey}}",
                "sort": "asc"
              }
{{/ifx}}
            ]
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run
        page = query.current_page()

        # p_{{snake settings.Models}}_as_table(result)

        expect(page.no).to eq(2)
        expect(page.size).to eq(3)
        expect(page.total).to eq(3)

        expect(result.length).to eq(page.total)

        # First record on the 2nd page
{{#ifx settings.no_key '==' true}}
        expect(result.first.id).to eq(@query_{{snake settings.Model}}_04.id)
{{else}}
        expect(result.first.{{snake settings.MainKey}}).to eq(@query_{{snake settings.Model}}_04.{{snake settings.MainKey}})
{{/ifx}}
      end

    end

    describe 'sort order' do

      it 'should query {{camelU settings.Model}} with sort by [{{snake settings.MainKey}} asc]' do

        config = <<-JSON
          {
            "sort": [
{{#ifx settings.no_key '==' true}}
                {
                  "field": "id",
                  "sort": "asc"
                }
{{else}}
                {
                  "field": "{{snake settings.MainKey}}",
                  "sort": "asc"
                }
{{/ifx}}
              ]
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run

        # p_{{snake settings.Models}}_as_table(result)

        # First record on the :first page
{{#ifx settings.no_key '==' true}}
        expect(result.first.id).to eq(@query_{{snake settings.Model}}_01.id)
{{else}}
        expect(result.first.{{snake settings.MainKey}}).to eq(@query_{{snake settings.Model}}_01.{{snake settings.MainKey}})
{{/ifx}}
      end

      it 'should query {{camelU settings.Model}} with sort by [{{#ifx settings.no_key '==' true}}id{{else}}{{snake settings.MainKey}}{{/ifx}} desc]' do

        config = <<-JSON
          {
            "sort": [
                {
                    "field": "{{#ifx settings.no_key '==' true}}id{{else}}{{snake settings.MainKey}}{{/ifx}}",
                    "sort": "desc"
                }
            ]
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run

        # p_{{snake settings.Models}}_as_table(result)

        # First record on the :first page
        expect(result.first.{{#ifx settings.no_key '==' true}}id{{else}}{{snake settings.MainKey}}{{/ifx}}).to eq(@query_{{snake settings.Model}}_13.{{#ifx settings.no_key '==' true}}id{{else}}{{snake settings.MainKey}}{{/ifx}})
      end

      # If you need multi column sorts then activate this unit test
      # xit 'should query {{camelU settings.Model}} with multiple sort conditions by [data desc, {{snake settings.MainKey}} desc]' do

      #   config = <<-JSON
      #     {
      #       "sort": [
      #           {
      #               "field": "data",
      #               "sort": "desc"
      #           },
      #           {
      #               "field": "{{snake settings.MainKey}}",
      #               "sort": "desc"
      #           }
      #       ]
      #     }
      #   JSON

      #   query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

      #   result = query.run

      #   # p_{{snake settings.Models}}_as_table(result)

      #   expect(result.first.{{snake settings.MainKey}}).to eq(@query_{{snake settings.Model}}_11.{{snake settings.MainKey}})
      # end

    end

  end

  context 'filtered queries' do

    before(:each) do
      full_data_set_for_query
    end

    describe 'filter by id' do

      it 'should query {{camelU settings.Model}} where id=1' do

        id = @query_{{snake settings.Model}}_01.id

        config = <<-JSON
          {
            "filter": {
              "id": "#{id}"
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run

        # p_{{snake settings.Models}}_as_table(result)

        expect(result.first.id).to eq(id)

      end

      it 'should query {{camelU settings.Model}} where id in (id1, id2, id3)' do

        ids = [
          999,
          @query_{{snake settings.Model}}_01.id,
          @query_{{snake settings.Model}}_04.id,
          @query_{{snake settings.Model}}_10.id
        ].join(',')

        config = <<-JSON
          {
            "filter": {
              "id": "#{ids}"
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake settings.Models}}_as_table(result)

        expect(result.length).to eq(3)

        expect(result.map(&:id)).to include(
                  @query_{{snake settings.Model}}_01.id,
                  @query_{{snake settings.Model}}_04.id,
                  @query_{{snake settings.Model}}_10.id)

      end

    end

    {{#array_has_key_value rows 'name' 'active'}}
    describe 'filter by active flag' do

      it 'should query {{camelU settings.Model}} where active = "all"' do

        config = <<-JSON
          {
            "filter": {
                "active": "all"
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake settings.Models}}_as_table(result)

        expect(result.find { |item| item.active == true }).to_not be_nil
        expect(result.find { |item| item.active == false }).to_not be_nil
      end


      it 'should query {{camelU settings.Model}} where active = "active"' do

        config = <<-JSON
          {
            "filter": {
                "active": "active"
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        # To array so that we are working off final data results
        result = query.run.to_a

        # p_{{snake settings.Models}}_as_table(result)

        expect(result.find { |item| item.active == true }).to_not be_nil
        expect(result.find { |item| item.active == false }).to be_nil
      end

      it 'should query {{camelU settings.Model}} where active = "inactive"' do

        config = <<-JSON
          {
            "filter": {
                "active": "inactive"
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake settings.Models}}_as_table(result)

        expect(result.find { |item| item.active == true }).to be_nil
        expect(result.find { |item| item.active == false }).to_not be_nil
      end

    end
    {{else}}
    # ACTIVE has been SKIPPED
    {{/array_has_key_value}}

{{#ifx settings.no_key '==' false}}
    describe 'filter by [combination of words] in {{snake settings.MainKey}} [ALL match]' do

      it 'should query {{camelU settings.Model}} where "ben" and "hurr" are in {{snake settings.MainKey}} ' do
        
        @query_{{snake settings.Model}}_01.{{snake settings.MainKey}} = 'ben+god+killer+hurr{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake settings.Model}}_01.save

        @query_{{snake settings.Model}}_02.{{snake settings.MainKey}} = 'Mr+Hurr+Ben{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake settings.Model}}_02.save

        @query_{{snake settings.Model}}_03.{{snake settings.MainKey}} = 'Ben+Jones{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake settings.Model}}_03.save

        @query_{{snake settings.Model}}_04.{{snake settings.MainKey}} = 'John+Hurr{{#array_has_key_value rows 'format_type' 'email'}}@email.com{{/array_has_key_value}}'
        @query_{{snake settings.Model}}_04.save

        config = <<-JSON
          {
            "filter": {
                "{{snake settings.MainKey}}": "ben hurr"
            }
          }
        JSON

        query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

        result = query.run.to_a                             # To array so that we are working off final data results

        # p_{{snake settings.Models}}_as_table(result)

        expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_01.{{snake settings.MainKey}})}).to_not be_nil
        expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_02.{{snake settings.MainKey}})}).to_not be_nil
        expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_03.{{snake settings.MainKey}})}).to be_nil
        expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_04.{{snake settings.MainKey}})}).to be_nil

        expect(result.length).to eq(2)

      end

    end
{{else}}
# NO_KEY has been SKIPPED
{{/ifx}}
    
    # Currently not implemented
    # xdescribe 'filter by [combination of words] in {{snake settings.MainKey}} [ANY match]' do

    #   it 'should query {{camelU settings.Model}} where "ben" and "hurr" are in {{snake settings.MainKey}}' do

    #     @query_{{snake settings.Model}}_01.{{snake settings.MainKey}} = 'ben+god+killer+hurr'
    #     @query_{{snake settings.Model}}_01.save

    #     @query_{{snake settings.Model}}_02.{{snake settings.MainKey}} = 'Mr+Hurr+Ben'
    #     @query_{{snake settings.Model}}_02.save

    #     @query_{{snake settings.Model}}_03.{{snake settings.MainKey}} = 'Ben+Jones'
    #     @query_{{snake settings.Model}}_03.save

    #     @query_{{snake settings.Model}}_04.{{snake settings.MainKey}} = 'John+Hurr'
    #     @query_{{snake settings.Model}}_04.save

    #     config = <<-JSON
    #       {
    #         "filter": {
    #             "{{snake settings.MainKey}}_any": "ben hurr"
    #         }
    #       }
    #     JSON

    #     query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

    #     result = query.run.to_a                             # To array so that we are working off final data results

    #     # p_{{snake settings.Models}}_as_table(result)

    #     expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_01.{{snake settings.MainKey}})}).to_not be_nil
    #     expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_02.{{snake settings.MainKey}})}).to_not be_nil
    #     expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_03.{{snake settings.MainKey}})}).to_not be_nil
    #     expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal?(@query_{{snake settings.Model}}_04.{{snake settings.MainKey}})}).to_not be_nil

    #     expect(result.length).to eq(4)

    #   end

    # end

    # Currently not implemented
    # xdescribe 'filter by [search value] in [any] field' do

    #   it 'should query {{camelU settings.Model}} where "weirdo" is in any searchable field' do

    #     @query_{{snake settings.Model}}_01.{{snake settings.MainKey}} = 'weirdo'
    #     @query_{{snake settings.Model}}_01.save

    #     @query_{{snake settings.Model}}_02.data = 'weirdo'
    #     @query_{{snake settings.Model}}_02.save

    #     @query_{{snake settings.Model}}_03.{{snake settings.MainKey}} = 'the weirdo'
    #     @query_{{snake settings.Model}}_03.save

    #     @query_{{snake settings.Model}}_04.data = 'weirdo in the house'
    #     @query_{{snake settings.Model}}_04.save

    #     @query_{{snake settings.Model}}_10.data = 'weirdo'
    #     @query_{{snake settings.Model}}_10.save

    #     config = <<-JSON
    #       {
    #         "filter": {
    #             "search": "weirdo"
    #         }
    #       }
    #     JSON

    #     query = Query::{{camelU settings.Model}}Query.new(config.parse_json)

    #     result = query.run.to_a                             # To array so that we are working off final data results

    #     # p_{{snake settings.Models}}_as_table()
    #     # p_{{snake settings.Models}}_as_table(result)

    #     expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal(@query_{{snake settings.Model}}_01.{{snake settings.MainKey}})}).to_not be_nil
    #     expect(result.find { |item| item.data.is_equal(@query_{{snake settings.Model}}_02.data)}).to_not be_nil
    #     expect(result.find { |item| item.{{snake settings.MainKey}}.is_equal(@query_{{snake settings.Model}}_03.{{snake settings.MainKey}})}).to_not be_nil
    #     expect(result.find { |item| item.data.is_equal(@query_{{snake settings.Model}}_04.data)}).to_not be_nil
    #     expect(result.find { |item| item.data.is_equal(@query_{{snake settings.Model}}_10.data)}).to_not be_nil

    #     expect(result.length).to eq(5)

    #   end

    # end

  end

  # ----------------------------------------------------------------------
  # {{camelU settings.Model}}s: Data Setup and Printing
  # ----------------------------------------------------------------------

  # data set for query unit tests
  def full_data_set_for_query
    {{#each settings.ParentDependencies}}
    td_{{snake this}}
    {{/each}}
    {{#each relations}}
    {{#ifx this.type '==' 'OneToOne'}}
    td_{{snake this.name_plural}}
{{/ifx}}
{{/each}}

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
