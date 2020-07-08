# frozen_string_literal: true

require 'spec_helper'
# require 'klue/klue'
RSpec.describe KDsl::DocumentDsl do
  let(:key) { 'some name' }

  # before(:example) do
  #   Klue.reset
  #   Klue.register(Rails.root)
  # end
  # after(:example) do
  #   # Klue.print
  # end

  describe 'constructor' do
    subject { described_class.new key }

    context 'with minimum params' do
      it {
        expect(subject).to have_attributes(
          key: 'some name',
          type: :entity,
          namespace: '',
          options: {},
          meta_data: {}
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

      context 'when options are provided' do
        let(:options) { { a: 1, b: '2' } }

        it { expect(subject.options).to eq(a: 1, b: '2') }
      end
    end
  end

  describe 'configure settings via block' do
    subject(:dsl) { described_class.new(key, &block) }

    context 'setting group' do

      context 'with default name' do
        let(:block) do
          lambda do |_|
            settings do
            end
          end
        end

        it { expect(subject.meta_data).to eq('settings' => {}) }
      end

      context 'with custom name' do
        let(:block) do
          lambda do |_|
            settings :key_values do
            end
          end
        end

        it { expect(subject.meta_data).to eq('key_values' => {}) }
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

        it { expect(subject.meta_data).to eq('settings' => {}, 'key_values' => {}, 'name_values' => {}) }
      end
    end

    context 'with key/values' do
      let(:block) do
        lambda do |_|
          settings do
            name              'user'
            rails_port        3000
            active            true
          end
        end
      end

      it do
        expect(subject.meta_data).to eq('settings' =>
          {
            'name' => 'user',
            'rails_port' => 3000,
            'active' => true
          })
      end
    end
  end

  #     it 'standard settings with visitor on setting' do
  #       dsl = Klue::Dsl::DocumentDsl.new name do 
  #         settings visitors: [Klue::Dsl::ArtifactSettingsVisitor] do
  #           rails_port        3000
  #           model             'User'
  #           active            true
  #         end
  #         settings :key_values do
  #           rails_port        3000
  #           model             'User'
  #           active            true
  #         end
  #       end

  #       expect(dsl.meta_data).to eq('settings' => {
  #                                         'rails_port' => 3000,
  #                                         'model' => 'User',
  #                                         'model_plural' => 'Users',
  #                                         'active' => true
  #                                       },
  #                                       'key_values' => {
  #                                         'rails_port' => 3000,
  #                                         'model' => 'User',
  #                                         'active' => true
  #                                       })
  #     end

  #     it 'standard settings with visitor on artifact' do
  #       dsl = Klue::Dsl::DocumentDsl.new name,
  #                                        visitors: [Klue::Dsl::ArtifactSettingsVisitor] do
  #         settings do
  #           rails_port        3000
  #           model             'User'
  #           active            true
  #         end
  #         settings :key_values do
  #           rails_port        3000
  #           model             'User'
  #           active            true
  #         end
  #       end

  #       expect(dsl.meta_data).to eq('settings' => {
  #                                         'rails_port' => 3000,
  #                                         'model' => 'User',
  #                                         'model_plural' => 'Users',
  #                                         'active' => true
  #                                       },
  #                                       'key_values' => {
  #                                         'rails_port' => 3000,
  #                                         'model' => 'User',
  #                                         'model_plural' => 'Users',
  #                                         'active' => true
  #                                       })
  #     end

  #     context 'with options' do
  #       subject {
  #         Klue::Dsl::DocumentDsl.new name, options do
  #           settings do
  #             first_name      'David'
  #             last_name       'Cruwys'
  #             full_name       'David Cruwys'
  #           end
  #         end
  #       }

  #       context 'upcase all values' do
  #         let(:options) { { upcase: true } }
  #         it { expect(subject.meta_data).to eq('settings' => { 'first_name' => 'DAVID', 'last_name' => 'CRUWYS', 'full_name' => 'DAVID CRUWYS' }) }
  #       end

  #       context 'downcase all values' do
  #         let(:options) { { downcase: true } }
  #         it { expect(subject.meta_data).to eq('settings' => { 'first_name' => 'david', 'last_name' => 'cruwys', 'full_name' => 'david cruwys' }) }
  #       end

  #       context 'change values with a visitor' do
  #         let(:options) { { visitors: [MockAlterKeyValues] } }
  #         it { expect(subject.meta_data).to eq('settings' => { 'first_name' => 'Davo', 'last_name' => 'The Great', 'full_name' => 'Davo The Great' }) }
  #       end

  #       context 'change and insert values with multiple visitors' do
  #         let(:options) { { visitors: [MockAlterKeyValues, MockAlterStructure] } }
  #         it { expect(subject.meta_data).to eq({'settings' => { 'first_name' => 'Davo', 'last_name' => 'The Great', 'funny_name' => 'Some Funny Name' }}) }
  #       end

  #     end

  #   end

  # end

  # describe 'config rows via block' do

  #   context 'row groups' do

  #     it 'default' do
  #       dsl = Klue::Dsl::DocumentDsl.new name do 
  #         rows do
  #         end
  #       end

  #       expect(dsl.type).to eq(:entity)
  #       expect(dsl.meta_data).to eq('rows' => { 'fields' =>[], 'rows' =>[] })
  #     end

  #     it 'custom' do
  #       dsl = Klue::Dsl::DocumentDsl.new name do 
  #         rows :custom_rows do
  #         end
  #       end
  
  #       expect(dsl.type).to eq(:entity)
  #       expect(dsl.meta_data).to eq('custom_rows' => { 'fields' =>[], 'rows' =>[] })
  #     end

  #     it 'multiple' do
  #       dsl = Klue::Dsl::DocumentDsl.new name do 
  #         rows :custom_rows1 do
  #         end

  #         rows do
  #         end

  #         rows :custom_rows2 do
  #         end

  #       end
  
  #       expect(dsl.meta_data).to eq({
  #         'custom_rows1' => { 'fields' =>[], 'rows' => [] },
  #         'rows' => { 'fields' =>[], 'rows' =>[] },
  #         'custom_rows2' => { 'fields' =>[], 'rows' =>[] }
  #         })
  #     end
  
  #   end
    
  #   context 'row values' do

  #     it 'multiple row groups, multiple rows and positional and key/valued data' do

  #       dsl = Klue::Dsl::DocumentDsl.new name   do 

  #         rows do

  #           fields [:column1, :column2, f(:column3, false), f(:column4, default: 'CUSTOM VALUE')]

  #           row 'row1-c1', 'row1-c2',  true, 'row1-c4'
  #           row   
    
  #         end

  #         rows :custom_rows do

  #           fields [:column1, :column2]

  #           row column1: 'david'  
  #           row column2: 'cruwys'
  
  #         end
  #       end

  #       # dsl.debug

  #       expect(dsl.meta_data).to eq({ 
  #         'rows' => { 
  #           'fields' => [
  #             { 'name' => 'column1', 'type' => 'string', 'default' => nil },
  #             { 'name' => 'column2', 'type' => 'string', 'default' => nil },
  #             { 'name' => 'column3', 'type' => 'string', 'default' => false },
  #             { 'name' => 'column4', 'type' => 'string', 'default' => 'CUSTOM VALUE' }
  #           ], 
  #           'rows' => [
  #             { 'column1' => 'row1-c1', 'column2' => 'row1-c2', 'column3' => true , 'column4' => 'row1-c4' },
  #             { 'column1' => nil      , 'column2' => nil      , 'column3' => false, 'column4' => 'CUSTOM VALUE' }
  #           ] 
  #         },
  #         'custom_rows' => { 
  #           'fields' => [
  #             { 'name' => 'column1', 'type' => 'string', 'default' => nil },
  #             { 'name' => 'column2', 'type' => 'string', 'default' => nil }
  #           ], 
  #           'rows' => [
  #             { 'column1' => 'david', 'column2' => nil },
  #             { 'column1' => nil    , 'column2' => 'cruwys' }
  #           ]
  #         }
  #       })

  #     end

  #   end

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

  # class MockAlterKeyValues
  #   def visit(hash)
  #     hash.keys.each do |key|
  #       if key.to_s == 'first_name'
  #         hash[key] = hash[key].gsub('David', 'Davo')
  #       end

  #       if key.to_s == 'last_name'
  #         hash[key] = hash[key].gsub('Cruwys', 'The Great')
  #       end

  #       if key.to_s == 'full_name'
  #         hash[key] = "#{hash[:first_name]} #{hash[:last_name]}"
  #       end
  #     end
  #   end
  # end

  # class MockAlterStructure
  #   def visit(hash)
  #     hash[:funny_name] = 'Some Funny Name'
  #     hash.delete(:full_name)
  #   end
  # end

end
