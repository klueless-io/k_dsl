# # frozen_string_literal: true

# require 'spec_helper'

# RSpec.describe KDsl::Resources::DslResource do
#   subject { resource }

#   let(:resource) { described_class.instance(project: project, file: file) }
#   let(:project) { KDsl::Manage::Project.new('sample_app') }
#   let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
#   let(:one_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/one_dsl.rb') }
#   let(:two_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/two_dsl.rb') }
#   let(:file) { one_dsl_file }

#   describe '#instance' do
#     it { is_expected.to have_attributes(file: file, type: described_class::TYPE_RUBY_DSL) }
#   end

#   describe '#load' do
#     before { resource.load }

#     context 'one_dsl' do
#       let(:file) { one_dsl_file }

#       context '.documents' do
#         subject { resource.documents }
  
#         it { is_expected.not_to be_empty }
#         it { expect(subject.length).to eq 1 }
#       end

#       context '.document 1' do
#         subject { resource.documents[0] }
  
#         it { expect(subject.data).to eq({
#           'settings' => {
#             'a' => "1",
#             'b' => 2
#           }
#         }) }
#       end
#     end

#     context 'two_dsl' do
#       let(:file) { two_dsl_file }

#       context '.document 1' do
#         subject { resource.documents[0] }
  
#         it { expect(subject.data).to eq({
#           'settings' => {
#             'rails_port' => 3000,
#             'app_path' => '~/somepath'
#           }
#         }) }
#       end

#       context '.document 2' do
#         subject { resource.documents[1] }
  
#         it { expect(subject.data).to eq(
#           {
#             "applets" => 
#               {
#                 "fields" => [
#                   { "default" => nil, "name" => "name", "type" => "string"},
#                   { "default" => true, "name" => "active", "type" => "string" }
#                 ], 
#                 "rows" => [
#                   {"active" => true, "name" => "rails5", "target_path"=>"~/somepath"},
#                   {"active" => false, "name" => "react", "target_path"=>"~/somepath/client"}
#                 ]
#               }
#           }) }
#       end
#     end

#   end
# end
