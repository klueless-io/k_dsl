# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::RowsDsl do

  let(:data) { {} }
  let(:instance) { described_class.new(data) }

  describe '#clean_symbol' do
    context 'when value is nil' do
      subject { instance.clean_symbol(nil) }

      it { is_expected.to be_nil }
    end

    context 'when value is string' do
      subject { instance.clean_symbol('a_string') }

      it { is_expected.to eq('a_string') }
    end

    context 'when value is :symbol' do
      subject { instance.clean_symbol(:a_symbol) }

      it { is_expected.to eq('a_symbol') }
    end
  end

  describe 'field' do
    context '@name of field' do
      context 'when name is string' do
        subject { instance.field('xmen') }

        it { is_expected.to include(name: 'xmen') }
      end

      context 'when name is symbol' do
        subject { instance.field(:xmen) }

        it { is_expected.to include(name: 'xmen') }
      end
    end

    context '@default value for field' do
      context 'when default not supplied' do
        subject { instance.field('xmen') }

        it { is_expected.to include(default: nil) }
      end

      context 'when default value parsed in as positional argument' do
        subject { instance.field('xmen', 'are great') }

        it { is_expected.to include(default: 'are great') }
      end

      context 'when default value parsed in named argument' do
        subject { instance.field('xmen', default: 'are excelent') }

        it { is_expected.to include(default: 'are excelent') }
      end

      # context 'when default value is parsed in as boolean' do
      #   context 'true' do
      #     subject { instance.field('xmen', default: true) }

      #     it { is_expected.to include(default: true) }
      #   end
      #   context 'false' do
      #     subject { instance.field('xmen', default: false) }

      #     it { is_expected.to include(default: false) }
      #   end
      # end
    end

    context '@type of field' do
      context 'when type not supplied' do
        subject { instance.field('xmen') }

        it { is_expected.to include(type: nil) }
      end

      context 'when type parsed in as positional argument' do
        subject { instance.field('xmen', nil, :string) }

        it { is_expected.to include(type: 'string') }
      end

      context 'when type parsed in named argument' do
        subject { instance.field('xmen', type: 'string') }

        it { is_expected.to include(type: 'string') }
      end
    end

    context '@name, @default_value, @type combinations' do
      context '3 x positional paramaters' do
        subject { instance.field('xmen', 'are excellent', 'string') }

        it { is_expected.to include(name: 'xmen', default: 'are excellent', type: 'string') }
      end

      context '3 x named paramaters' do
        subject { instance.field('xmen', type: 'text', default: 'are awesome') }

        it { is_expected.to include(name: 'xmen', default: 'are awesome', type: 'text') }
      end

      # Often fields are defined using positional args
      # But a named default value may be introduced for override/specitivity reasons
      context 'edge cases when using 3 positional paramaters + default:' do
        subject { instance.field('xmen', nil, type, default: default) }

        let(:type) { 'string' }
        let(:default) { 'some string' }

        context 'when default is string' do
          it { is_expected.to include(name: 'xmen', type: 'string', default: 'some string') }
        end

        context 'when type is boolean' do
          let(:type) { 'boolean' }
          let(:default) { true }

          context 'with true value' do
            it { is_expected.to include(name: 'xmen', type: 'boolean', default: true) }
          end

          context 'with false value' do
            let(:default) { false }
            it { is_expected.to include(name: 'xmen', type: 'boolean', default: false) }
          end
        end
      end
    end
  end

#   describe 'configure rows via block' do

#     # context 'rows groupings' do
#     #   it 'name defaults to :rows' do
#     #     KDsl::RowsDsl.new(data)

#     #     expect(data).to eq({ 'rows' => { 'fields' => [], 'rows' => [] } })
#     #   end

#     #   it 'name :people' do
#     #     KDsl::RowsDsl.new(data, :people)

#     #     expect(data).to eq({ 'people' => { 'fields' => [], 'rows' => [] } })
#     #   end

#     #   it 'name :people and places and rows' do
#     #     KDsl::RowsDsl.new(data, :people)
#     #     KDsl::RowsDsl.new(data)
#     #     KDsl::RowsDsl.new(data, :places)


#     #     expect(data).to eq({ 
#     #       'people' => { 'fields' => [], 'rows' => [] },
#     #       'rows' =>   { 'fields' => [], 'rows' => [] },
#     #       'places' => { 'fields' => [], 'rows' => [] }
#     #     })
#     #   end
#     # end

#     # context 'configure fields' do

#     #   it 'simple fields' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:name, :type, :title, :default, :required, :reference_type, :db_type, :format_type, :description]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'name'           , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'type'           , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'title'          , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'default'        , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'required'       , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'reference_type' , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'db_type'        , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'format_type'    , 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'description'    , 'type' => 'string', 'default' => nil }
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'fields with custom default value for column2' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:column1, field(:column2, 'CUSTOM DEFAULT')]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => 'CUSTOM DEFAULT' },
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'fields with custom default boolean FALSE' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [field(:column1, false), field(:column2, default: false)]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => false },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => false }
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'fields with custom default boolean TRUE' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [field(:column1, true), field(:column2, default: true)]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => true },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => true }
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'fields with custom type & default value in column2' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:column1, field(:column2, 333, :integer)]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string' , 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'integer', 'default' => 333 },
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'fields with custom type & default value in column2 using the (f) alias' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:column1, f(:column2, 3.33, type: :float)]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'float' , 'default' => 3.33 },
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'fields with custom type & default value in column2 using named paramaters' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:column1, f(:column2, default: 'CUSTOM VALUE', type: 'customtype')]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string'     , 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'customtype' , 'default' => 'CUSTOM VALUE' },
#     #         ], 
#     #         'rows' => [] }
#     #     })

#     #   end

#     #   it 'mixed fields' do

#     #     KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:name, f(:type, 'String'), f(:title, ''), f(:default, nil), f(:required, true, :bool), :reference_type, :db_type, :format_type, :description]
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'name'           , 'type' => 'string' , 'default' => nil },
#     #           { 'name' => 'type'           , 'type' => 'string' , 'default' => 'String' },
#     #           { 'name' => 'title'          , 'type' => 'string' , 'default' => '' },
#     #           { 'name' => 'default'        , 'type' => 'string' , 'default' => nil },
#     #           { 'name' => 'required'       , 'type' => 'bool'   , 'default' => true },
#     #           { 'name' => 'reference_type' , 'type' => 'string' , 'default' => nil },
#     #           { 'name' => 'db_type'        , 'type' => 'string' , 'default' => nil },
#     #           { 'name' => 'format_type'    , 'type' => 'string' , 'default' => nil },
#     #           { 'name' => 'description'    , 'type' => 'string' , 'default' => nil }
#     #         ],
#     #         'rows' => [] }
#     #     })

#     #   end

#     # end

#     # describe 'get fields' do

#     #   it 'get fields' do

#     #     dsl = KDsl::RowsDsl.new(data, :rows) do
#     #       fields [:name, :type]
#     #     end

#     #     expect(dsl.get_fields).to eq(
#     #         [
#     #           { 'name' => 'name', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'type', 'type' => 'string', 'default' => nil }
#     #         ]
#     #     )

#     #   end

#     # end

#     # describe 'row with positional arguments' do
      
#     #   # r.fields [:column1, f(:column2, 'DEFAULT VALUE'), f(:column3, true, :bool), f(:column4, type: bool)]
#     #   it 'add 2xrows, 2xcolumns with nil data' do
#     #     KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2]

#     #       row   
#     #       row   
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => nil }
#     #         ], 
#     #         'rows' => [
#     #           { 'column1' => nil, 'column2' => nil },
#     #           { 'column1' => nil, 'column2' => nil }
#     #         ] }
#     #       })
#     #   end

#     #   it 'add 2xrows, 2xcolumns with data' do
#     #     KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2]

#     #       row   'row1-c1', 'row1-c2'
#     #       row   'row2-c1', 'row2-c2'
#     #     end
  
#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => nil }
#     #         ], 
#     #         'rows' => [
#     #           { 'column1' => 'row1-c1', 'column2' => 'row1-c2' },
#     #           { 'column1' => 'row2-c1', 'column2' => 'row2-c2' }
#     #         ] }
#     #       })
#     #   end

#     #   it 'add 2xrows, 2xcolumns with mixed nil and data' do
#     #     KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2]

#     #       row   nil, 'row1-c2'
#     #       row   'row2-c1'
#     #     end
  
#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => nil }
#     #         ], 
#     #         'rows' => [
#     #           { 'column1' => nil      , 'column2' => 'row1-c2' },
#     #           { 'column1' => 'row2-c1', 'column2' => nil }
#     #         ] }
#     #       })
#     #   end

#     #   it 'add 2xrows, 2xcolumns with mixed default types' do
#     #     KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2, f(:column3, false)]

#     #       row   nil, 'row1-c2', true
#     #       row   'row2-c1'
#     #     end
  
#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column3', 'type' => 'string', 'default' => false }
#     #         ], 
#     #         'rows' => [
#     #           { 'column1' => nil      , 'column2' => 'row1-c2', 'column3' => true },
#     #           { 'column1' => 'row2-c1', 'column2' => nil      , 'column3' => false }
#     #         ] }
#     #       })
#     #   end

#     # end

#     # describe 'row with named arguments' do
          
#     #       # r.fields [:column1, f(:column2, 'DEFAULT VALUE'), f(:column3, true, :bool), f(:column4, type: bool)]
#     #   it 'add 2xrows, 2xcolumns with named values' do
#     #     KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2]

#     #       row column1: 'david'  
#     #       row column2: 'cruwys'
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => nil }
#     #         ], 
#     #         'rows' => [
#     #           { 'column1' => 'david' , 'column2' => nil },
#     #           { 'column1' => nil     , 'column2' => 'cruwys' }
#     #         ] }
#     #       })
#     #   end

#     # end

#     # describe 'row with positional and named args' do
#     #       # r.fields [:column1, f(:column2, 'DEFAULT VALUE'), f(:column3, true, :bool), f(:column4, type: bool)]
#     #   it 'add 2xrows, 2xcolumns with named values' do
#     #     KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2]

#     #       row 'david'  
#     #       row column2: 'cruwys'
#     #     end

#     #     expect(data).to eq({ 
#     #       'rows' => { 
#     #         'fields' => [
#     #           { 'name' => 'column1', 'type' => 'string', 'default' => nil },
#     #           { 'name' => 'column2', 'type' => 'string', 'default' => nil }
#     #         ], 
#     #         'rows' => [
#     #           { 'column1' => 'david' , 'column2' => nil },
#     #           { 'column1' => nil     , 'column2' => 'cruwys' }
#     #         ] }
#     #       })
#     #   end

#     # end

#     # describe 'get rows' do


#     #   subject { KDsl::RowsDsl.new(data) do
#     #       fields [:column1, :column2]

#     #       row 1
#     #       row 2
#     #       row 3 
#     #     end
#     #   }

#     #   it 'get all rows' do

#     #     expect(subject.get_rows).to eq(
#     #       [
#     #         { 'column1' => 1, 'column2' => nil },
#     #         { 'column1' => 2, 'column2' => nil },
#     #         { 'column1' => 3, 'column2' => nil }
#     #       ]
#     #     )

#     #   end

#     #   it 'get rows by search' do

#     #     expect(subject.get_rows.select { |r| [1,3].include?(r['column1']) }).to eq(
#     #       [
#     #         { 'column1' => 1, 'column2' => nil },
#     #         { 'column1' => 3, 'column2' => nil }
#     #       ]
#     #     )

#     #   end

#     #   it 'find row by key/value' do

#     #     expect(subject.find_row('column1', 2)).to eq({ 'column1' => 2, 'column2' => nil })

#     #   end

#     # end
#   end
end
