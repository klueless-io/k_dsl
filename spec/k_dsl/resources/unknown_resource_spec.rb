# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Resources::UnknownResource do
  subject { resource }

  let(:resource) do
    KDsl::Resources::Resource.instance(
      project: project,
      file: file
  )
  end

  let(:project) { KDsl::Manage::Project.new('sample') }
  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
  let(:file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.xxx') }

  describe '#instance' do
    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_UNKNOWN) }
  end

  describe '.documents' do
    subject { resource.documents }

    it { is_expected.to be_empty }

    context '#load' do
      before { resource.load }

      it { is_expected.not_to be_empty }

      it 'has one document with data' do
        expect(subject.length).to eq 1
        expect(subject.first.data).to eq({})
      end

      it 'has key' do
        expect(subject.first.key).to eq('sample')
      end

      it 'has type' do
        expect(subject.first.type).to eq('unknown')
      end

      # it do
      #   resource.debug
      # end
    end
  end
end
