# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Artifacts::Artifact do
  subject { artifact }

  let(:artifact) { described_class.new(resource, key) }
  let(:resource) { KDsl::Resources::Resource.instance(project: project, file: file) }
  let(:project) { KDsl::Manage::Project.new('sample_app') }
  let(:key) { 'sample' }

  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
  # let(:csv_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.csv') }
  # let(:json_file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.json') }
  # let(:ruby_file) { File.join(gem_root, 'spec/factories/dsls/ruby_files/ruby1.rb') }
  # let(:ruby_dsl_file) { File.join(gem_root, 'spec/factories/dsls/simple_dsl/some_dsl.rb') }

  let(:file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.csv') }

  describe '#constructor' do
    let(:artifact) { described_class.new(resource, key) }

    it { is_expected.to have_attributes(key: 'sample', type: :entity, namespace: nil, resource: resource, state: KDsl::Artifacts::Artifact::STATE_LOADED)}

    context 'when resource not supplied' do
      let(:resource) { nil }

      it { expect { subject }.to raise_error(KDsl::Error, 'Resource is required') }
    end
    
    context 'when resource is not a KDsl::Resources::Resource' do
      let(:resource) { 'not_right_type' }

      it { expect { subject }.to raise_error(KDsl::Error, "Resource is must be a 'KDsl::Resources::Resource'") }
    end
    
    context 'when key not supplied' do
      let(:key) { nil }

      it { expect { subject }.to raise_error(KDsl::Error, 'Key is required') }
    end

    context 'when key is symbol' do
      let(:key) { :sample }

      it { is_expected.to have_attributes(key: 'sample')}
    end
  end
end
