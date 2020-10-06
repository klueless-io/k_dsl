# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Model::Document do
  subject { described_class.new(key, &block) }

  let(:key) { 'some_name' }
  let(:type) { :controller }
  let(:namespace) { :spaceman }
  let(:block) { nil }

  class Pluralizer
    def update(data)
      return unless data.key?('model') && (!data.key?('model_plural') || data['model_plural'].nil?)

      data['model_plural'] = "#{data['model']}s"
    end
  end

  class AlterKeyValues
    def update(data)
      data.update(data) do |key, value|
        if key.to_s == 'first_name'
          value.gsub('David', 'Davo')
        elsif key.to_s == 'last_name'
          value.gsub('Cruwys', 'The Great')
        else
          value
        end
      end
      data['full_name'] = "#{data['first_name']} #{data['last_name']}"
    end
  end

  class AlterStructure
    def update(data)
      return unless data.key?('full_name')

      data['funny_name'] = data['full_name'].downcase
      data.delete('full_name')
    end
  end

  describe '#constructor' do
    context 'with key only' do
      subject { described_class.new(key) }

      it 'key is set' do
        expect(subject.key).to eq(key)
      end
      it 'type has default value' do
        expect(subject.type).to eq(KDsl.config.default_document_type)
      end
      it 'namespace is empty' do
        expect(subject.namespace).to be_empty
      end
      it 'options are empty' do
        expect(subject.options).to be_empty
      end
    end

    context 'with key, type' do
      subject { described_class.new(key, type) }

      it 'key is set' do
        expect(subject.key).to eq(key)
      end
      it 'type is set' do
        expect(subject.type).to eq(type)
      end
      it 'namespace is empty' do
        expect(subject.namespace).to be_empty
      end
      it 'options are empty' do
        expect(subject.options).to be_empty
      end
    end

    context 'with key, type, namespace' do
      subject { described_class.new(key, type, namespace: namespace) }

      it 'key is set' do
        expect(subject.key).to eq(key)
      end
      it 'type is set' do
        expect(subject.type).to eq(type)
      end
      it 'namespace is set' do
        expect(subject.namespace).to eq('spaceman')
      end
      it 'options have namespace' do
        expect(subject.options).to eq namespace: :spaceman
      end
    end

    context 'with options' do
      subject { described_class.new(key, type, **options ) }

      let(:options) { {} }

      context 'when options are nil' do
        it { expect(subject.options).to eq({}) }
      end

      context 'when custom options are provided' do
        let(:options) { { a: 1, b: '2' } }

        it { expect(subject.options).to eq(a: 1, b: '2') }
      end
    end

    context 'with &block' do
      subject { described_class.new key, **options, &block }

      let(:options) { {} }
      let(:block) do
        lambda do |_|
          @data = { thunder_birds: :are_go }
        end
      end

      context 'when given a block' do
        it { expect(subject.data).to eq({}) }

        context 'after execute_block' do
          before { subject.execute_block }            
          it { expect(subject.data).to eq(thunder_birds: :are_go) }
        end
      end
    end
  end

  describe '.unique_key' do
    context 'with key' do
      subject { described_class.new(key).unique_key }

      it { expect(subject).to eq("some_name_#{KDsl.config.default_document_type}") }
    end

    context 'with key and type' do
      subject { described_class.new(key, type).unique_key }

      it { expect(subject).to eq('some_name_controller') }
    end

    context 'with key, type and namespace' do
      subject { described_class.new(key, type, namespace: namespace).unique_key }

      it { expect(subject).to eq('spaceman_some_name_controller') }
    end
  end

  describe '#' do
    context 'with minimum params' do
      it {
        expect(subject).to have_attributes(
          key: 'some_name',
          type: :entity,
          namespace: '',
          options: {},
          data: {}
        )
      }
    end

    context 'with type' do
      subject { described_class.new key, type }

      context 'when nil' do
        let(:type) { nil }

        it { expect(subject.type).to eq(KDsl.config.default_document_type) }
      end

      context 'when :some_data_type' do
        let(:type) { :some_data_type }

        it { expect(subject.type).to eq(:some_data_type) }
      end
    end

    context 'with namespace' do
      subject { described_class.new key, namespace: namespace }

      context 'when nil' do
        let(:namespace) { nil }

        it { expect(subject.namespace).to eq('') }
      end

      context 'when :some_namespace' do
        let(:namespace) { :some_namespace }

        it { expect(subject.namespace).to eq('some_namespace') }
      end
    end

    context 'with options' do
      let(:options) { {} }

      subject { described_class.new key, **options }

      context 'when options are nil' do
        it { expect(subject.options).to eq({}) }
      end

      context 'when custom options are provided' do
        let(:options) { { a: 1, b: '2' } }

        it { expect(subject.options).to eq(a: 1, b: '2') }
      end
    end

    context 'with &block' do
      subject { described_class.new key, **options, &block }

      let(:options) { {} }
      let(:block) do
        lambda do |_|
          @data = { thunder_birds: :are_go }
        end
      end

      it { expect(subject.data).to eq({}) }

      context 'after execute_block' do
        before { subject.execute_block }            

        it { expect(subject.data).to eq(thunder_birds: :are_go) }
      end
    end
  end

  describe 'configure settings' do
    subject { described_class.new(key, &block) }

    before { subject.execute_block }

    context 'setting groups' do
      context 'with default name' do
        let(:block) do
          lambda do |_|
            settings do
            end
          end
        end

        it { expect(subject.data).to eq('settings' => {}) }
      end

      context 'with custom name' do
        let(:block) do
          lambda do |_|
            settings :key_values do
            end
          end
        end

        it { expect(subject.data).to eq('key_values' => {}) }
      end

      context 'with multiple groups' do
        let(:block) do
          lambda do |_|
            settings do
            end
            settings :key_values do
            end
            settings :name_values do
            end
          end
        end

        it { expect(subject.data).to eq('settings' => {}, 'key_values' => {}, 'name_values' => {}) }
      end
    end

    context 'default DI/IOC class' do
      subject { described_class.new(key).settings }

      it { expect(subject).to be_a(KDsl::Model::Settings) }
    end

    context 'setting key/values' do
      let(:block) do
        lambda do |_|
          settings do
            model             'user'
            rails_port        3000
            active            true
          end
        end
      end

      it do
        expect(subject.data).to eq('settings' =>
          {
            'model' => 'user',
            'rails_port' => 3000,
            'active' => true
          })
      end

      context 'with decorators - sample 1' do
        let(:block) do
          lambda do |_|
            settings decorators: [Pluralizer, :uppercase] do
              model             'user'
              rails_port        3000
              active            true
            end
          end
        end

        it do
          expect(subject.data).to eq('settings' =>
            {
              'model' => 'USER',
              'model_plural' => 'USERS',
              'rails_port' => 3000,
              'active' => true
            })
        end
      end

      context 'with decorators - sample 2' do
        let(:block) do
          lambda do |_|
            settings decorators: [AlterKeyValues, AlterStructure] do
              first_name 'David'
              last_name 'Cruwys'
              age 40
            end
          end
        end

        it do
          expect(subject.data).to eq('settings' =>
            {
              'first_name' => 'Davo',
              'last_name' => 'The Great',
              'funny_name' => 'davo the great',
              'age' => 40
            })
        end
      end
    end
  end

  describe 'configure table' do
    subject(:dsl) { described_class.new(key, &block) }

    before do
      dsl.execute_block
    end

    context 'table groups' do
      context 'with default key' do
        let(:block) do
          lambda do |_|
            table do
            end
          end
        end

        it { expect(subject.type).to eq(:entity) }
        it { expect(subject.data).to eq('table' => { 'fields' => [], 'rows' => [] }) }
      end

      context 'with custom key' do
        let(:block) do
          lambda do |_|
            table :custom do
            end
          end
        end

        it { expect(subject.data).to eq('custom' => { 'fields' => [], 'rows' => [] }) }
      end

      context 'default DI/IOC class' do
        subject { described_class.new(key).table }

        it { expect(subject).to be_a(KDsl::Model::Table) }
      end

      context 'with multiple tables' do
        let(:block) do
          lambda do |_|
            table do
            end

            table :table2 do
            end

            table :table3 do
            end
          end
        end

        it do
          expect(subject.data).to eq({
                                       'table' => { 'fields' => [], 'rows' => [] },
                                       'table2' => { 'fields' => [], 'rows' => [] },
                                       'table3' => { 'fields' => [], 'rows' => [] }
                                     })
        end
      end
    end

    context 'table rows' do
      subject(:dsl) { described_class.new(key, &block) }

      let(:block) do
        lambda do |_|
          table do
            fields [:column1, :column2, f(:column3, false), f(:column4, default: 'CUSTOM VALUE')]

            row 'row1-c1', 'row1-c2', true, 'row1-c4'
            row
          end

          table :another_table do
            fields %w[column1 column2]

            row column1: 'david'
            row column2: 'cruwys'
          end
        end
      end

      it 'multiple row groups, multiple rows and positional and key/valued data' do
        # dsl.debug

        expect(dsl.data).to eq({
                                 'table' => {
                                   'fields' => [
                                     { 'name' => 'column1', 'type' => 'string', 'default' => nil },
                                     { 'name' => 'column2', 'type' => 'string', 'default' => nil },
                                     { 'name' => 'column3', 'type' => 'string', 'default' => false },
                                     { 'name' => 'column4', 'type' => 'string', 'default' => 'CUSTOM VALUE' }
                                   ],
                                   'rows' => [
                                     { 'column1' => 'row1-c1', 'column2' => 'row1-c2', 'column3' => true , 'column4' => 'row1-c4' },
                                     { 'column1' => nil, 'column2' => nil, 'column3' => false, 'column4' => 'CUSTOM VALUE' }
                                   ]
                                 },
                                 'another_table' => {
                                   'fields' => [
                                     { 'name' => 'column1', 'type' => 'string', 'default' => nil },
                                     { 'name' => 'column2', 'type' => 'string', 'default' => nil }
                                   ],
                                   'rows' => [
                                     { 'column1' => 'david', 'column2' => nil },
                                     { 'column1' => nil, 'column2' => 'cruwys' }
                                   ]
                                 }
                               })
      end
    end
  end

  #   describe 'write as' do

  #     let(:some_file) { Tempfile.new() }
  #     let(:json_file) { Tempfile.new(['','.json']) }
  #     let(:yaml_file) { Tempfile.new(['','.yaml']) }
      
  #     after do
  #       some_file.unlink
  #       json_file.unlink
  #       yaml_file.unlink
  #     end

  #     subject {
  #       Klue::Dsl::DocumentDsl.new name do 
  #         settings do
  #           rails_port        3000
  #           model             'User'
  #           active            true
  #         end

  #         rows :custom_rows do

  #           fields [:column1, :column2, f(:column3, false)]

  #           row column1: 'david'  
  #           row 'david','cruwys', column3: true

  #         end
  #       end
  #     }

  #     context 'data' do

  #       it 'fail to write for unknown extension' do
  #         expect { subject.write_data(some_file.path) }.to raise_error 'Provide a valid extension or as_type. Supported types: [json, yaml]'
  #       end
        
  #       it 'fail to write for unknown as_type' do
  #         expect { subject.write_data(some_file.path, as_type: :abc) }.to raise_error 'Provide a valid extension or as_type. Supported types: [json, yaml]'
  #       end

  #       it 'write data as_type :json' do
  #         subject.write_data(some_file.path, as_type: :json)
  #         expect(File.exist?(some_file.path)).to be_truthy
  #       end

  #       it 'write data as json' do
  #         subject.write_data(json_file.path)
  #         expect(File.exist?(json_file.path)).to be_truthy
  #       end

  #       it 'write data as_type :yaml' do
  #         subject.write_data(some_file.path, as_type: :yaml)
  #         expect(File.exist?(some_file.path)).to be_truthy
  #       end

  #       it 'write data as yaml' do
  #         subject.write_data(yaml_file.path)
  #         expect(File.exist?(yaml_file.path)).to be_truthy
  #       end

  #     end

  #     context 'data' do

  #       it 'fail to write for unknown extension' do
  #         expect { subject.write_meta(some_file.path) }.to raise_error 'Provide a valid extension or as_type. Supported types: [json, yaml]'
  #       end
        
  #       it 'fail to write for unknown as_type' do
  #         expect { subject.write_meta(some_file.path, as_type: :abc) }.to raise_error 'Provide a valid extension or as_type. Supported types: [json, yaml]'
  #       end

  #       it 'write data as_type :json' do
  #         subject.write_meta(some_file.path, as_type: :json)
  #         expect(File.exist?(some_file.path)).to be_truthy
  #       end
 
  #       it 'write data as json' do
  #         subject.write_meta(json_file.path)
  #         expect(File.exist?(json_file.path)).to be_truthy
  #       end

  #       it 'write data as_type :yaml' do
  #         subject.write_meta(some_file.path, as_type: :yaml)
  #         expect(File.exist?(some_file.path)).to be_truthy
  #       end

  #       it 'write data as yaml' do
  #         subject.write_meta(yaml_file.path)
  #         expect(File.exist?(yaml_file.path)).to be_truthy
  #       end

  #     end

  #   end

  # end

  # describe 'klue.process_code' do

  #   context 'single document' do

  #     subject { 
  #       Klue.process_code(
  #         <<-RUBY
  #     Klue::Dsl::DocumentDsl.new 'parent' do 
  #       settings do
  #         first_name      'David'
  #         last_name       'Cruwys'
  #       end
  #     end
  #         RUBY
  #       )
  #     }
  
  #     let(:parent) { Klue.register_instance.get_data('parent')}
  
  #     it do
  #       subject
  #       expect(parent).to_not be_nil
  #     end
  #     it do
  #       subject
  #       expect(parent).to eq("settings" => { "first_name"=>"David", "last_name"=>"Cruwys" })
  #     end
    
  #   end

  #   context 'multiple documents' do

  #     subject { 
  #       Klue.process_code(
  #         <<-RUBY
  #     Klue::Dsl::DocumentDsl.new 'parent' do 
  #       settings do
  #         first_name      'David'
  #         last_name       'Cruwys'
  #       end
  #     end

  #     Klue::Dsl::DocumentDsl.new 'child' do 
  #       settings do
  #         age      'Old'
  #         sex      'Male'
  #       end
  #     end
  #       RUBY
  #       ) 
  #     }
  
  #     let(:parent) { Klue.register_instance.get_data('parent')}
  #     let(:child) { Klue.register_instance.get_data('child')}
  
  #     it do
  #       subject
  #       expect(parent).to_not be_nil
  #     end

  #     it do
  #       subject
  #       expect(child).to_not be_nil
  #     end

  #     it do
  #       subject
  #       expect(parent).to eq({"settings"=>{"first_name"=>"David", "last_name"=>"Cruwys"}})
  #     end

  #     it do
  #       subject
  #       expect(child).to eq({"settings"=>{"age"=>"Old", "sex"=>"Male"}})
  #     end
  
  #   end

  #   context 'multiple documents where child imports from parent' do

  #     subject { Klue.process_code(
  #     <<-RUBY
  
  #       Klue::Dsl::DocumentDsl.new 'parent' do 
  #         settings do
  #           first_name      'David'
  #           last_name       'Cruwys'
  #         end
  #       end
  
  #       Klue::Dsl::DocumentDsl.new 'child' do 
  
  #         p = import('parent')
  
  #         settings do
  #           first_name      p.settings.first_name
  #           last_name       p.settings.last_name
  #           age      'Old'
  #           sex      'Male'
  #         end
  #       end
  
  #     RUBY
  #     ) }
  
  #     let(:parent) { Klue.register_instance.get_data('parent')}
  #     let(:child) { Klue.register_instance.get_data('child')}
  
  #     it { subject; expect(parent).to_not be_nil }
  #     it { subject; expect(child).to_not be_nil }
  #     it { subject; expect(parent).to eq({"settings"=>{"first_name"=>"David", "last_name"=>"Cruwys"}}) }
  #     it { subject; expect(child).to eq({"settings"=>{"first_name"=>"David", "last_name"=>"Cruwys", "age"=>"Old", "sex"=>"Male"}}) }
  
  #   end
  
  # end


  # describe 'to_struct' do

  #   subject { Klue::Dsl::DocumentDsl.to_struct(data) }

  #   context 'simple settings' do
  #     let(:data) { { "settings": {"a":"A", "b": 1, "c": true, "d": false} } }

  #     it { expect(subject.settings).to_not be_nil }
  #     it { expect(subject.settings.a).to eq("A") }
  #     it { expect(subject.settings.b).to eq(1) }
  #     it { expect(subject.settings.c).to eq(true) }
  #     it { expect(subject.settings.d).to eq(false) }
  #   end

  #   context 'array of rows' do
  #     let(:data) { { "rows": [
  #       {"c1":"A", "c2": 1},
  #       {"c1":"B", "c2": true},
  #       {"c1":"C", "c2": false}
  #       ] } }

  #     it { expect(subject.rows).to_not be_nil }
  #     it { expect(subject.rows.length).to eq(3) }
  #     it { expect(subject.rows[0].c1).to eq('A') }
  #     it { expect(subject.rows[0].c2).to eq(1) }
  #     it { expect(subject.rows[1].c1).to eq('B') }
  #     it { expect(subject.rows[1].c2).to eq(true) }
  #     it { expect(subject.rows[2].c1).to eq('C') }
  #     it { expect(subject.rows[2].c2).to eq(false) }
  #   end

  #   context 'complex - rows and settings' do
  #     let(:data) { { 
  #       "options": {
  #         "a":"A", 
  #         "b": 1, 
  #         "c": true, 
  #         "d": false
  #         }, 
  #       "records": [
  #         {"c1":"A", "c2": 1}
  #       ],
  #       "rows": [
  #         {"f1":"B", "f2": true},
  #         {"f1":"C", "f2": false}
  #       ]
  #     } }

  #     it { expect(subject.options).to_not be_nil }
  #     it { expect(subject.options.a).to eq("A") }
  #     it { expect(subject.options.b).to eq(1) }
  #     it { expect(subject.options.c).to eq(true) }
  #     it { expect(subject.options.d).to eq(false) }

  #     it { expect(subject.records[0].c1).to eq('A') }
  #     it { expect(subject.records[0].c2).to eq(1) }

  #     it { expect(subject.rows[0].f1).to eq('B') }
  #     it { expect(subject.rows[0].f2).to eq(true) }
  #     it { expect(subject.rows[1].f1).to eq('C') }
  #     it { expect(subject.rows[1].f2).to eq(false) }
  #   end
  # end

end
