# # frozen_string_literal: true

# require 'spec_helper'

# RSpec.describe KDsl::Model::Register do
#   subject { described_class.new }
#   # let(:base_dsl_path1) { File.join(Rails.root, 'spec', '_', 'klue-files') }
#   # let(:base_dsl_path2) { Rails.root }

#   # let(:register_dsl1) { Klue::Dsl::RegisterDsl.create(base_dsl_path1) }
#   # let(:register_dsl2) { Klue::Dsl::RegisterDsl.create(base_dsl_path2) }

#   # subject { register_dsl1 }

#   # let(:bad_k_key) { '../klue-files-edgecases/bad_k_key.rb' }

#   # let(:basic_user_file) { 'common-auth/basic_user.rb' }
#   # let(:admin_user_file) { 'common-auth/admin_user.rb' }

#   # let(:admin_user_as_domain_file) { '../klue-files-edgecases/admin_user_domain.rb' }
#   # let(:admin_user_already_registered_file) { '../klue-files-edgecases/admin_user_already_registered.rb' }

#   # DYNAMIC_ADMIN_USER_SAMPLE = <<-RUBY
      
#   #   Klue.artifact 'admin_user' do

#   #     settings do
#   #       model_type           'AdminUser'
#   #     end
#   #   end

#   # RUBY

#   # DYNAMIC_BASIC_USER_SAMPLE = <<-RUBY

#   #   Klue.artifact :basic_user do

#   #     settings do
#   #       model_type           'BasicUser'
#   #     end
#   #   end

#   # RUBY

#   # DYNAMIC_DSLS = <<-RUBY

#   # Klue.artifact :admin_user do
#   # end

#   # Klue.artifact :basic_user do
#   # end

#   # Klue.microapp :my_app do
#   # end

#   # Klue.artifact :admin_user, namespace: 'child' do
#   # end

#   # Klue.artifact :basic_user, namespace: 'child' do
#   # end

#   # RUBY

#   # DSLS_DIFF_TYPE_SAME_KEY = <<-RUBY
 
#   # Klue.artifact :great_name do
#   # end

#   # Klue.microapp :great_name do
#   # end

#   # RUBY

#   # DSLS_DIFF_NAMESPACE_SAME_KEY = <<-RUBY

#   # Klue.artifact :great_name do
#   # end

#   # Klue.artifact :great_name, namespace: 'a' do
#   # end

#   # Klue.artifact :great_name, namespace: 'b' do
#   # end

#   # RUBY

#   # let(:content_admin_user) { DYNAMIC_ADMIN_USER_SAMPLE }
#   # let(:content_basic_user) { DYNAMIC_BASIC_USER_SAMPLE }
#   # let(:content_dsls) { DYNAMIC_DSLS }
#   # let(:content_dsls_great_name_diff_type) { DSLS_DIFF_TYPE_SAME_KEY }
#   # let(:content_dsls_great_name_diff_namespace) { DSLS_DIFF_NAMESPACE_SAME_KEY }

#   # describe 'construction' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }

#   #   context 'fails via private constructor' do
#   #     it { expect { Klue::Dsl::RegisterDsl.new(base_dsl_path2) }.to raise_error(NoMethodError) }
#   #   end

#   #   context 'with minimum params' do
#   #     let(:with_min_param_registered_dsl) { Klue::Dsl::RegisterDsl.create(base_dsl_path2) }

#   #     it { expect(with_min_param_registered_dsl).to_not be_nil }
#   #     it { expect(with_min_param_registered_dsl.base_dsl_path).to end_with('klue-less') }
#   #     it { expect(with_min_param_registered_dsl.base_data_path).to end_with('klue-less/.data') }
#   #     it { expect(with_min_param_registered_dsl.base_definition_path).to end_with('klue-less/.definition') }
#   #     it { expect(with_min_param_registered_dsl.base_template_path).to end_with('klue-less/.template') }
#   #     it { expect(with_min_param_registered_dsl.base_app_template_path).to end_with('klue-less/.template_app') }
      
#   #     it { expect(with_min_param_registered_dsl.dsls).to eq({}) }
#   #     it { expect(with_min_param_registered_dsl.current_state).to eq(:dynamic) }
#   #     it { expect(with_min_param_registered_dsl.current_register_file).to be_nil }
#   #   end

#   #   context 'with custom data folder' do
#   #     let(:with_data_registered_dsl) { Klue::Dsl::RegisterDsl.create(base_dsl_path2, base_data_path: File.join(base_dsl_path2, '_data')) }

#   #     it { expect(with_data_registered_dsl.base_dsl_path).to end_with('klue-less') }
#   #     it { expect(with_data_registered_dsl.base_data_path).to end_with('klue-less/_data') }
#   #   end

#   #   context 'with custom data folder' do
#   #     let(:with_definition_registered_dsl) { Klue::Dsl::RegisterDsl.create(base_dsl_path2, base_definition_path: File.join(base_dsl_path2, '_definition')) }

#   #     it { expect(with_definition_registered_dsl.base_dsl_path).to end_with('klue-less') }
#   #     it { expect(with_definition_registered_dsl.base_data_path).to end_with('klue-less/.data') }
#   #     it { expect(with_definition_registered_dsl.base_definition_path).to end_with('klue-less/_definition') }
#   #   end
    
#   #   context 'with custom template folder' do
#   #     let(:with_data_registered_dsl) { Klue::Dsl::RegisterDsl.create(base_dsl_path2, base_template_path: File.join(base_dsl_path2, '_template')) }

#   #     it { expect(with_data_registered_dsl.base_dsl_path).to end_with('klue-less') }
#   #     it { expect(with_data_registered_dsl.base_template_path).to end_with('klue-less/_template') }
#   #   end

#   # end

#   # describe 'build_unique_key' do

#   #   context 'with default namespace and type' do
#   #     subject { register_dsl1.build_unique_key('my_key') } 

#   #     it { is_expected.to eq('my_key_entity')}
#   #   end

#   #   context 'with custom namespace and default type' do
#   #     subject { register_dsl1.build_unique_key('my_key', 'my_space') }

#   #     it { is_expected.to eq('my_space_my_key_entity')}
#   #   end

#   #   context 'with default namespace and custom type' do
#   #     subject { register_dsl1.build_unique_key('my_key', nil, 'my_type') }

#   #     it { is_expected.to eq('my_key_my_type')}
#   #   end

#   #   context 'with custom namespace and type' do
#   #     subject { register_dsl1.build_unique_key('my_key', 'my_space', 'my_type') }

#   #     it { is_expected.to eq('my_space_my_key_my_type')}
#   #   end

#   # end

#   # describe 'get_dsl' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }

#   #   context 'when dsl is loaded' do

#   #     it 'get_dsl with name and default type' do
#   #       subject.load_dynamic(content_admin_user)

#   #       dsl = subject.get_dsl('admin_user')

#   #       expect(dsl).to_not be_nil
#   #       expect(dsl[:state]).to eq(:loaded)
#   #     end

#   #     it 'get_dsl with name and provided type' do
#   #       subject.load_dynamic(content_admin_user)

#   #       dsl = subject.get_dsl(:admin_user, nil, :entity)

#   #       expect(dsl).to_not be_nil
#   #       expect(dsl[:state]).to eq(:loaded)
#   #     end

#   #     it 'get_dsl with name and invalid type' do
#   #       subject.load_dynamic(content_admin_user)

#   #       dsl = subject.get_dsl(:admin_user, :invalid_type)

#   #       expect(dsl).to be_nil
#   #     end

#   #     context 'same names and different types' do

#   #       it 'get_dsl with default type' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_type)

#   #         dsl = subject.get_dsl(:great_name)

#   #         expect(dsl).to_not be_nil
#   #         expect(dsl[:state]).to eq(:loaded)
#   #         expect(dsl[:k_type]).to eq(:entity)
#   #       end

#   #       it 'get_dsl with entity type' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_type)

#   #         dsl = subject.get_dsl(:great_name, nil, :entity)

#   #         expect(dsl).to_not be_nil
#   #         expect(dsl[:state]).to eq(:loaded)
#   #         expect(dsl[:k_type]).to eq(:entity)
#   #       end

#   #       it 'get undefined dsl for valid type' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_type)

#   #         dsl = subject.get_dsl(:great_name, nil, :structure)

#   #         expect(dsl).to be_nil
#   #       end

#   #       it 'get_dsl with microapp type' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_type)

#   #         dsl = subject.get_dsl(:great_name, nil, :microapp)

#   #         expect(dsl).to_not be_nil
#   #         expect(dsl[:state]).to eq(:loaded)
#   #         expect(dsl[:k_type]).to eq(:microapp)
#   #       end
#   #     end

#   #     context 'same names and different namespaces' do

#   #       it 'get_dsl with default namespace' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_namespace)

#   #         dsl = subject.get_dsl(:great_name)

#   #         expect(dsl).to_not be_nil
#   #         expect(dsl[:state]).to eq(:loaded)
#   #         expect(dsl[:namespace]).to be_blank
#   #       end

#   #       it 'get_dsl with namespace "a"' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_namespace)

#   #         dsl = subject.get_dsl(:great_name, 'a')

#   #         expect(dsl).to_not be_nil
#   #         expect(dsl[:state]).to eq(:loaded)
#   #         expect(dsl[:namespace]).to eq('a')
#   #       end

#   #       it 'get_dsl with namespace "b"' do
#   #         subject.load_dynamic(content_dsls_great_name_diff_namespace)

#   #         dsl = subject.get_dsl(:great_name, 'b')

#   #         expect(dsl).to_not be_nil
#   #         expect(dsl[:state]).to eq(:loaded)
#   #         expect(dsl[:namespace]).to eq('b')
#   #       end
#   #     end

#   #   end

#   #   context 'when dsl is registered' do
#   #     it 'with name and default type' do
#   #       subject.register_file(admin_user_file)

#   #       dsl = subject.get_dsl('admin_user')

#   #       expect(dsl).to_not be_nil
#   #       expect(dsl[:state]).to eq(:registered)
#   #     end
#   #   end

#   # end

#   # describe 'get_dsl_by_type' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }

#   #   context 'when dsls is loaded' do

#   #     it 'get_dsls by default type' do
#   #       subject.load_dynamic(content_dsls)

#   #       dsls = subject.get_dsls_by_type()

#   #       expect(dsls.length).to eq(4)
#   #       expect(dsls[0][:k_type]).to eq(:entity)
#   #       expect(dsls[0][:namespace]).to be_blank
#   #       expect(dsls[1][:k_type]).to eq(:entity)
#   #       expect(dsls[1][:namespace]).to be_blank
#   #       expect(dsls[2][:k_type]).to eq(:entity)
#   #       expect(dsls[2][:namespace]).to eq('child')
#   #       expect(dsls[3][:k_type]).to eq(:entity)
#   #       expect(dsls[3][:namespace]).to eq('child')
#   #     end

#   #     it 'get_dsls by :entity type' do
#   #       subject.load_dynamic(content_dsls)

#   #       dsls = subject.get_dsls_by_type(:entity)

#   #       expect(dsls.length).to eq(4)
#   #     end
    
#   #     it 'get_dsls by :microapp type' do
#   #       subject.load_dynamic(content_dsls)

#   #       dsls = subject.get_dsls_by_type(:microapp)

#   #       expect(dsls.length).to eq(1)
#   #       expect(dsls[0][:k_type]).to eq(:microapp)
#   #     end

#   #     context 'when namespace provided' do

#   #       it 'get_dsls by default type' do
#   #         subject.load_dynamic(content_dsls)

#   #         dsls = subject.get_dsls_by_type(:entity, '')

#   #         expect(dsls.length).to eq(2)
#   #         expect(dsls[0][:k_type]).to eq(:entity)
#   #         expect(dsls[0][:namespace]).to be_blank
#   #         expect(dsls[1][:k_type]).to eq(:entity)
#   #         expect(dsls[1][:namespace]).to be_blank
#   #       end

#   #       it 'get_dsls by default type' do
#   #         subject.load_dynamic(content_dsls)

#   #         dsls = subject.get_dsls_by_type(:entity, 'child')

#   #         expect(dsls.length).to eq(2)
#   #         expect(dsls[0][:k_type]).to eq(:entity)
#   #         expect(dsls[0][:namespace]).to eq('child')
#   #         expect(dsls[1][:k_type]).to eq(:entity)
#   #         expect(dsls[1][:namespace]).to eq('child')
#   #       end

#   #     end
    
#   #   end

#   # end

#   # describe 'get_data' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }

#   #   context 'when dsl is loaded' do
#   #     it 'with name and default type' do
#   #       subject.load_dynamic(content_admin_user)

#   #       data = subject.get_data('admin_user')

#   #       expect(data).to eq({"settings"=>{"model_type"=>"AdminUser"}})

#   #       expect(data).to_not be_nil
#   #     end

#   #     it 'with name and provided type' do
#   #       subject.load_dynamic(content_admin_user)

#   #       data = subject.get_data(:admin_user, nil, :entity)
#   #       expect(data).to eq({"settings"=>{"model_type"=>"AdminUser"}})

#   #       expect(data).to_not be_nil
#   #     end

#   #     it 'should raise error on get_data when DSL does not exist' do
#   #       subject.load_dynamic(content_admin_user)

#   #       expect { subject.get_data(:admin_user, nil, :invalid_type) }.to raise_error('Could not get data for missing DSL: admin_user_invalid_type')
#   #     end
#   #   end

#   #   context 'when dsl is registered' do
#   #     it 'with name and default type' do
#   #       subject.register_file(admin_user_file)
#   #       # Klue.print

#   #       expect(subject.get_dsl(:admin_user, nil, :entity)[:state]).to eq(:registered)
#   #       data = subject.get_data(:admin_user, nil, :entity)
#   #       expect(subject.get_dsl(:admin_user, nil, :entity)[:state]).to eq(:loaded)
        
#   #       expect(data).to_not be_nil

#   #       expect(data["settings"]).to_not be_nil
#   #       expect(data["db_table"]).to_not be_nil
#   #       expect(data["rows"]).to_not be_nil
#   #       expect(data["relations"]).to_not be_nil

#   #     end
#   #   end

#   # end

#   # describe 'is_pathname_absolute' do

#   #   it { expect(subject.is_pathname_absolute('somefile.rb')).to be_falsey }
#   #   it { expect(subject.is_pathname_absolute('somepath/somefile.rb')).to be_falsey }

#   #   it { expect(subject.is_pathname_absolute('/somefile.rb')).to be_truthy }
#   #   it { expect(subject.is_pathname_absolute('~/somefile.rb')).to be_falsey }

#   # end

#   # describe 'expand_path' do

#   #   it { expect(subject.expand_path('somefile.rb')).to end_with('klue-less/spec/_/klue-files/somefile.rb') }
#   #   it { expect(subject.expand_path('somepath/somefile.rb')).to end_with('klue-less/spec/_/klue-files/somepath/somefile.rb') }
#   #   it { expect(subject.expand_path('/somefile.rb')).to eq('/somefile.rb') }

#   #   it { expect(subject.expand_path('~/somefile.rb')).to start_with('/Users') & end_with('/somefile.rb') }
#   #   it { expect(subject.expand_path('~/somefile.rb')).to_not include('klue-less') }
    
#   # end

#   # describe 'get_relative_folder' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }

#   #   context 'dsl path 1' do
#   #     subject { register_dsl1 }

#   #     it { expect(subject.get_relative_folder(File.join(base_dsl_path1, 'a','b','c','somefile.rb'))).to eq('a/b/c') }
#   #     it { expect(subject.get_relative_folder(File.join(base_dsl_path1, 'a','b','c','somefile'))).to eq('a/b/c') }
#   #     it { expect(subject.get_relative_folder(File.join(base_dsl_path1, 'somefile.rb'))).to eq('.') }

#   #   end

#   #   context 'dsl path 2' do
#   #     subject { register_dsl2 }

#   #     it { expect(subject.get_relative_folder(File.join(base_dsl_path2, 'a','b','c','somefile.rb'))).to eq('a/b/c') }
#   #     it { expect(subject.get_relative_folder(File.join(base_dsl_path2, 'a','b','c','somefile'))).to eq('a/b/c') }
#   #     it { expect(subject.get_relative_folder(File.join(base_dsl_path2, 'somefile.rb'))).to eq('.') }

#   #   end
    
#   # end

#   # describe 'registration' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }
#   #   after(:example) {
#   #     # Klue.print
#   #   }

#   #   describe 'register_file' do

#   #     context 'raise error on bad k_key' do
#   #       it "k_key must be string or symbol" do
#   #         expect { subject.register_file(bad_k_key) }.to raise_error(Klue::Dsl::DslError, 'k_key must be a string or symbol')
#   #       end
#   #     end

#   #     context 'with k_key as string' do
        
#   #       it 'should register file' do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_file(admin_user_file)
#   #         expect(subject.dsls.values.length).to eq(1)

#   #         expect(subject.dsls.values.first).to include(
#   #           k_key: 'admin_user', 
#   #           k_type: :entity,
#   #           state: :registered,
#   #           data: nil,
#   #           source: :file,
#   #           file: File.join(base_dsl_path1, admin_user_file)
#   #         )
       
#   #       end
      
#   #     end

#   #     context 'with k_key as symbol' do
        
#   #       it 'should register file' do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_file(basic_user_file)
#   #         expect(subject.dsls.values.length).to eq(1)
          
#   #         expect(subject.dsls.values.first).to include(
#   #           k_key: :basic_user, 
#   #           k_type: :entity,
#   #           state: :registered,
#   #           data: nil,
#   #           source: :file,
#   #           file: File.join(base_dsl_path1, basic_user_file)
#   #         )

#   #       end
      
#   #     end

#   #     context 'multiple file register' do
  
#   #       it 'should register multiple files with same k_type and different k_key' do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_file(admin_user_file)
#   #         subject.register_file(basic_user_file)
#   #         expect(subject.dsls.values.length).to eq(2)
#   #       end

#   #       it 'should register multiple files with diffent k_type and same k_key' do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_file(admin_user_file)
#   #         subject.register_file(basic_user_file)
#   #         subject.register_file(admin_user_as_domain_file)
#   #         expect(subject.dsls.values.length).to eq(3)
#   #       end

#   #       it 'should fail to register when duplicate k_type / k_key encountered' do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_file(admin_user_file)
#   #         expect { subject.register_file(admin_user_already_registered_file) }.to raise_error(Klue::Dsl::DslError, "Duplicate DSL key found admin_user_entity in different files")
#   #         expect(subject.dsls.values.length).to eq(1)
#   #       end

#   #     end

#   #   end
  
#   #   describe 'register_path' do

#   #     context 'with valid files' do
      
#   #       it "register multiple DSL's from single folder" do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_path('common-auth/*.rb')
#   #         expect(subject.dsls.values.length).to eq(2)
#   #       end
#   #     end

#   #     context 'with valid files in deep nested path' do
      
#   #       it "register multiple DSL's from single folder" do
#   #         expect(subject.dsls.values.length).to eq(0)
#   #         subject.register_path('**/*.rb')
#   #         expect(subject.dsls.values.length).to eq(5)
#   #       end
#   #     end

#   #   end

#   # end

#   # describe 'load_file' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }
#   #   after(:example) {
#   #     # Klue.print
#   #   }

#   #   context 'load file' do
      
#   #     it 'should load admin_user dsl' do
#   #       expect(subject.dsls.values.length).to eq(0)
#   #       subject.load_file(admin_user_file)
#   #       expect(subject.dsls.values.length).to eq(1)
        
#   #       expect(subject.dsls.values.first).to include(
#   #         k_key: 'admin_user', 
#   #         k_type: :entity,
#   #         state: :loaded,
#   #         source: :file,
#   #         file: File.join(base_dsl_path1, admin_user_file)
#   #       )
      
#   #     end

#   #     it 'should load basic_user dsl' do
#   #       expect(subject.dsls.values.length).to eq(0)
#   #       subject.load_file(basic_user_file)
#   #       expect(subject.dsls.values.length).to eq(1)
        
#   #       expect(subject.dsls.values.first).to include(
#   #         k_key: :basic_user, 
#   #         k_type: :entity,
#   #         state: :loaded,
#   #         source: :file,
#   #         file: File.join(base_dsl_path1, basic_user_file)
#   #       )
      
#   #     end

#   #   end

#   # end

#   # describe 'load_dynamic' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }
#   #   after(:example) {
#   #     # Klue.print
#   #   }

#   #   context 'dynamic admin_user' do
      
#   #     it 'should load admin_user dsl via content' do
#   #       expect(subject.dsls.values.length).to eq(0)
#   #       subject.load_dynamic(content_admin_user)
#   #       expect(subject.dsls.values.length).to eq(1)
        
#   #       expect(subject.dsls.values.first).to include(
#   #         k_key: 'admin_user', 
#   #         k_type: :entity,
#   #         state: :loaded,
#   #         source: :dynamic
#   #       )
      
#   #     end

#   #     it 'should load basic_user dsl via content' do
#   #       expect(subject.dsls.values.length).to eq(0)
#   #       subject.load_dynamic(content_basic_user)
#   #       expect(subject.dsls.values.length).to eq(1)
        
#   #       expect(subject.dsls.values.first).to include(
#   #         k_key: :basic_user, 
#   #         k_type: :entity,
#   #         state: :loaded,
#   #         source: :dynamic
#   #       )
      
#   #     end

#   #   end

#   # end
  
#   # describe 'multiple DSL loading over time' do

#   #   before(:example) {
#   #     Klue.reset
#   #   }
#   #   after(:example) {
#   #   }

#   #   it 'register file then load file then dynamic content' do
    
#   #     expect(subject.dsls.values.length).to eq(0)
#   #     subject.register_path('common-auth/*.rb')
#   #     expect(subject.dsls.values.length).to eq(2)

#   #     # Klue.print

#   #     expect(subject.dsls.values[0]).to include(
#   #       k_key: 'admin_user', 
#   #       k_type: :entity,
#   #       state: :registered,
#   #       save_at: nil,
#   #       data: nil,
#   #       last_at: nil,
#   #       last_data: nil,
#   #       source: :file,
#   #       file: File.join(base_dsl_path1, admin_user_file)
#   #     )

#   #     expect(subject.dsls.values[1]).to include(
#   #       k_key: :basic_user, 
#   #       k_type: :entity,
#   #       state: :registered,
#   #       save_at: nil,
#   #       data: nil,
#   #       last_at: nil,
#   #       last_data: nil,
#   #       source: :file,
#   #       file: File.join(base_dsl_path1, basic_user_file)
#   #     )

#   #     subject.load_file(admin_user_file)

#   #     # Klue.print

#   #     expect(subject.dsls.values[0][:save_at]).to_not be_nil
#   #     expect(subject.dsls.values[0][:data]).to_not be_nil

#   #     expect(subject.dsls.values.first).to include(
#   #       k_key: 'admin_user', 
#   #       k_type: :entity,
#   #       state: :loaded,
#   #       last_at: nil,
#   #       last_data: nil,
#   #       source: :file,
#   #       file: File.join(base_dsl_path1, admin_user_file)
#   #     )

#   #     # L.heading('load_file')
#   #     # puts subject.dsls.values.first[:data]

#   #     # sleep(1)

#   #     subject.load_dynamic(content_admin_user)

#   #     # L.heading('load_dynamic')
#   #     # puts subject.dsls.values.first[:data]
#   #     # puts subject.dsls.values.first[:last_data]

#   #     # Klue.print

#   #     expect(subject.dsls.values[0][:save_at]).to_not be_nil
#   #     expect(subject.dsls.values[0][:data]).to_not be_nil
#   #     expect(subject.dsls.values[0][:last_at]).to_not be_nil
#   #     expect(subject.dsls.values[0][:last_data]).to_not be_nil

#   #     expect(subject.dsls.values.first).to include(
#   #       k_key: 'admin_user', 
#   #       k_type: :entity,
#   #       state: :loaded,
#   #       source: :file
#   #     )

#   #   end

#   # end

#   # REGISTER_DSL = <<-RUBY
#   #   Klue.register File.join(Rails.root, 'spec', '_', 'klue-files') do
#   #     register_path('common-auth/**/*.rb')
#   #     register_path('micro-app/**/*.rb')
#   #   end
#   # RUBY

#   # describe 'run register DSL' do

#   #   after(:example) {
#   #     # Klue.print
#   #   }

#   #   it 'as DSL in code' do
#   #     Klue.register(File.join(Rails.root, 'spec', '_', 'klue-files')) do
#   #       register_path('common-auth/**/*.rb')
#   #       register_path('micro-app/**/*.rb')
#   #     end
#   #   end

#   #   it 'as DSL in eval(string)' do
#   #     eval(REGISTER_DSL)
#   #   end
  
#   # end

# end
