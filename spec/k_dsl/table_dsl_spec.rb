# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::TableDsl do
  let(:data) { {} }
  let(:instance) { described_class.new(data) }

  describe '#clean_symbol' do
    subject { instance.clean_symbol(value) }

    let(:value) { nil }

    context 'when value is nil' do
      it { is_expected.to be_nil }
    end

    context 'when value is string' do
      let(:value) { 'a_string' }

      it { is_expected.to eq('a_string') }
    end

    context 'when value is :symbol' do
      let(:value) { :a_symbol }

      it { is_expected.to eq('a_symbol') }
    end
  end

  describe '#field' do
    context '@name of field' do
      context 'when name is string' do
        subject { instance.field('xmen') }

        it { is_expected.to include('name' => 'xmen') }
      end

      context 'when name is symbol' do
        subject { instance.field(:xmen) }

        it { is_expected.to include('name' => 'xmen') }
      end
    end

    context '@default value for field' do
      context 'when default not supplied' do
        subject { instance.field('xmen') }

        it { is_expected.to include('default' => nil) }
      end

      context 'when default value parsed in as positional argument' do
        subject { instance.field('xmen', 'are great') }

        it { is_expected.to include('default' => 'are great') }
      end

      context 'when default value parsed in named argument' do
        subject { instance.field('xmen', default: 'are excelent') }

        it { is_expected.to include('default' => 'are excelent') }
      end
    end

    context '@type of field' do
      context 'when type not supplied' do
        subject { instance.field('xmen') }

        it { is_expected.to include('type' => 'string') }
      end

      context 'when type parsed in as positional argument' do
        subject { instance.field('xmen', nil, :boolean) }

        it { is_expected.to include('type' => 'boolean') }
      end

      context 'when type parsed in named argument' do
        subject { instance.field('xmen', type: 'boolean') }

        it { is_expected.to include('type' => 'boolean') }
      end
    end

    context '@name, @default_value, @type combinations' do
      context '2 x positional paramaters' do
        subject { instance.field('xmen', 'are excellent', 'decimal') }

        it { is_expected.to include('name' => 'xmen', 'default' => 'are excellent', 'type' => 'decimal') }
      end

      context '2 x named paramaters' do
        subject { instance.field('xmen', type: 'text', default: 'are awesome') }

        it { is_expected.to include('name' => 'xmen', 'default' => 'are awesome', 'type' => 'text') }
      end

      # Often fields are defined using positional args
      # But a named default value may be introduced for override/specitivity reasons
      context 'edge cases when using 3 positional paramaters + :default' do
        subject { instance.field('xmen', nil, type, default: default) }

        let(:type) { 'string' }
        let(:default) { 'some string' }

        context 'when default is string' do
          it { is_expected.to include('name' => 'xmen', 'type' => 'string', 'default' => 'some string') }
        end

        context 'when type is boolean' do
          let(:type) { 'boolean' }
          let(:default) { true }

          context 'with true value' do
            it { is_expected.to include('name' => 'xmen', 'type' => 'boolean', 'default' => true) }
          end

          context 'with false value' do
            let(:default) { false }
            it { is_expected.to include('name' => 'xmen', 'type' => 'boolean', 'default' => false) }
          end
        end
      end
    end
  end

  describe '#get_fields' do
    it 'get fields' do
      dsl = KDsl::TableDsl.new(data, :rows) do
        fields %i[name type]
      end

      expect(dsl.get_fields).to eq(
        [
          { 'name' => 'name', 'type' => 'string', 'default' => nil },
          { 'name' => 'type', 'type' => 'string', 'default' => nil }
        ]
      )
    end
  end

  describe '#fields (configuration)' do
    it 'minimal configuration' do
      KDsl::TableDsl.new(data) do
      end

      expect(data).to eq(
        KDsl.config.default_rows_key.to_s => {
          'fields' => [],
          'rows' => []
        }
      )
    end

    it 'simple fields' do
      KDsl::TableDsl.new(data, :items) do
        fields %i[column1 column2]
      end

      expect(data).to eq(
        'items' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'string', 'default' => nil }
          ],
          'rows' => []
        }
      )
    end

    it 'fields with custom default value for column2' do
      KDsl::TableDsl.new(data, :rows) do
        fields [:column1, field(:column2, 'CUSTOM DEFAULT')]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'string', 'default' => 'CUSTOM DEFAULT' }
          ],
          'rows' => []
        }
      )
    end

    it 'fields with custom default boolean FALSE' do
      KDsl::TableDsl.new(data, :rows) do
        fields [field(:column1, false), field(:column2, default: false)]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => false },
            { 'name' => 'column2', 'type' => 'string', 'default' => false }
          ],
          'rows' => []
        }
      )
    end

    it 'fields with custom default boolean TRUE' do
      KDsl::TableDsl.new(data, :rows) do
        fields [field(:column1, true), field(:column2, default: true)]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => true },
            { 'name' => 'column2', 'type' => 'string', 'default' => true }
          ],
          'rows' => []
        }
      )
    end

    it 'fields with custom type & default value in column2' do
      KDsl::TableDsl.new(data, :rows) do
        fields [:column1, field(:column2, 333, :integer)]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'integer', 'default' => 333 }
          ],
          'rows' => []
        }
      )
    end

    it 'fields with custom type & default value in column2 using the (f) alias' do
      KDsl::TableDsl.new(data, :rows) do
        fields [:column1, f(:column2, 3.33, type: :float)]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'float', 'default' => 3.33 }
          ],
          'rows' => []
        }
      )
    end

    it 'fields with custom type & default value in column2 using named paramaters' do
      KDsl::TableDsl.new(data, :rows) do
        fields [:column1, f(:column2, default: 'CUSTOM VALUE', type: 'customtype')]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'customtype', 'default' => 'CUSTOM VALUE' }
          ],
          'rows' => []
        }
      )
    end

    it 'mixed fields' do
      KDsl::TableDsl.new(data, :rows) do
        fields [:name, f(:type, 'String'), f(:title, ''), f(:default, nil), f(:required, true, :bool), :reference_type, :db_type, :format_type, :description]
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'name', 'type' => 'string', 'default' => nil },
            { 'name' => 'type', 'type' => 'string', 'default' => 'String' },
            { 'name' => 'title', 'type' => 'string', 'default' => '' },
            { 'name' => 'default', 'type' => 'string', 'default' => nil },
            { 'name' => 'required', 'type' => 'bool', 'default' => true },
            { 'name' => 'reference_type', 'type' => 'string', 'default' => nil },
            { 'name' => 'db_type', 'type' => 'string', 'default' => nil },
            { 'name' => 'format_type', 'type' => 'string', 'default' => nil },
            { 'name' => 'description', 'type' => 'string', 'default' => nil }
          ],
          'rows' => []
        }
      )
    end
  end

  describe '#rows (configuration)' do
    context 'row groupings' do
      it 'name defaults to :rows' do
        KDsl::TableDsl.new(data)

        expect(data).to eq('rows' => { 'fields' => [], 'rows' => [] })
      end

      it 'name :people' do
        KDsl::TableDsl.new(data, :people)

        expect(data).to eq('people' => { 'fields' => [], 'rows' => [] })
      end

      it 'name :people and places and rows' do
        KDsl::TableDsl.new(data, :people)
        KDsl::TableDsl.new(data)
        KDsl::TableDsl.new(data, :places)

        expect(data).to eq(
          'people' => { 'fields' => [], 'rows' => [] },
          'rows' => { 'fields' => [], 'rows' => [] },
          'places' => { 'fields' => [], 'rows' => [] }
        )
      end
    end
  end

  describe 'table (configuration)' do
    context 'using positional arguments' do
      it 'with 2 rows, 2 columns and nil data' do
        KDsl::TableDsl.new(data) do
          fields %i[column1 column2]

          row
          row
        end

        expect(data).to eq(
          'rows' => {
            'fields' => [
              { 'name' => 'column1', 'type' => 'string', 'default' => nil },
              { 'name' => 'column2', 'type' => 'string', 'default' => nil }
            ],
            'rows' => [
              { 'column1' => nil, 'column2' => nil },
              { 'column1' => nil, 'column2' => nil }
            ]
          }
        )
      end

      it 'with 2 rows, 2 columns and data' do
        KDsl::TableDsl.new(data) do
          fields %i[column1 column2]

          row   'row1-c1', 'row1-c2'
          row   'row2-c1', 'row2-c2'
        end

        expect(data).to eq(
          'rows' => {
            'fields' => [
              { 'name' => 'column1', 'type' => 'string', 'default' => nil },
              { 'name' => 'column2', 'type' => 'string', 'default' => nil }
            ],
            'rows' => [
              { 'column1' => 'row1-c1', 'column2' => 'row1-c2' },
              { 'column1' => 'row2-c1', 'column2' => 'row2-c2' }
            ]
          }
        )
      end

      it 'with 2 rows, 2 columns using mixed nil mixed data' do
        KDsl::TableDsl.new(data) do
          fields %i[column1 column2]

          row   nil, 'row1-c2'
          row   'row2-c1'
        end

        expect(data).to eq(
          'rows' => {
            'fields' => [
              { 'name' => 'column1', 'type' => 'string', 'default' => nil },
              { 'name' => 'column2', 'type' => 'string', 'default' => nil }
            ],
            'rows' => [
              { 'column1' => nil, 'column2' => 'row1-c2' },
              { 'column1' => 'row2-c1', 'column2' => nil }
            ]
          }
        )
      end

      it 'with 2 rows, 3 columns using mixed default types' do
        KDsl::TableDsl.new(data) do
          fields [:column1, :column2, f(:column3, false)]

          row   nil, 'row1-c2', true
          row   'row2-c1'
        end

        expect(data).to eq(
          'rows' => {
            'fields' => [
              { 'name' => 'column1', 'type' => 'string', 'default' => nil },
              { 'name' => 'column2', 'type' => 'string', 'default' => nil },
              { 'name' => 'column3', 'type' => 'string', 'default' => false }
            ],
            'rows' => [
              { 'column1' => nil, 'column2' => 'row1-c2', 'column3' => true },
              { 'column1' => 'row2-c1', 'column2' => nil, 'column3' => false }
            ]
          }
        )
      end
    end
  end

  context 'using named arguments' do
    it 'with 2 rows, 2 columns using named values' do
      KDsl::TableDsl.new(data) do
        fields %i[column1 column2]

        row column1: 'david'
        row column2: 'cruwys'
      end

      # puts JSON.pretty_generate(data)

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'string', 'default' => nil }
          ],
          'rows' => [
            { 'column1' => 'david', 'column2' => nil },
            { 'column1' => nil, 'column2' => 'cruwys' }
          ]
        }
      )
    end
  end

  context 'using positional and named arguments' do
    it 'add 2 rows, 2 columns with named values' do
      KDsl::TableDsl.new(data) do
        fields %i[column1 column2]

        row 'david'
        row column2: 'cruwys'
      end

      expect(data).to eq(
        'rows' => {
          'fields' => [
            { 'name' => 'column1', 'type' => 'string', 'default' => nil },
            { 'name' => 'column2', 'type' => 'string', 'default' => nil }
          ],
          'rows' => [
            { 'column1' => 'david', 'column2' => nil },
            { 'column1' => nil, 'column2' => 'cruwys' }
          ]
        }
      )
    end
  end

  describe 'get rows' do
    subject do
      KDsl::TableDsl.new(data) do
        fields %i[column1 column2]

        row 1
        row 2
        row 3
      end
    end

    it 'get all rows' do
      expect(subject.get_rows).to eq(
        [
          { 'column1' => 1, 'column2' => nil },
          { 'column1' => 2, 'column2' => nil },
          { 'column1' => 3, 'column2' => nil }
        ]
      )
    end

    it 'get rows by search' do
      expect(subject.get_rows.select { |r| [1, 3].include?(r['column1']) }).to eq(
        [
          { 'column1' => 1, 'column2' => nil },
          { 'column1' => 3, 'column2' => nil }
        ]
      )
    end

    it 'find row by key/value' do
      expect(subject.find_row('column1', 2)).to eq({ 'column1' => 2, 'column2' => nil })
    end
  end
end
