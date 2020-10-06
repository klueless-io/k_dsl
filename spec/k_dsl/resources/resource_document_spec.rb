# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Resources::ResourceDocument do
  subject { resource_document }

  let(:resource_document) { described_class.new(resource, resource.documents.first) }
  let(:project) { KDsl::Manage::Project.new('sample_app') }
  let(:resource) { KDsl::Resources::Resource.instance(project: project, file: file) }

  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
  let(:csv_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.csv') }
  let(:json_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.json') }
  let(:ruby_file) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb') }
  let(:ruby_one_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/one_dsl.rb') }
  let(:ruby_two_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/two_dsl.rb') }
  let(:file) { csv_file }

  describe '#constructor' do
    before { resource.add_new_document }

    it 'is linked to resource' do
      expect(subject.resource).not_to be_nil
    end

    it 'is linked to document' do
      expect(subject.document).not_to be_nil
    end

    it 'is status registered' do
      expect(subject.status).to eq(:initialized)
    end
  end  
end
