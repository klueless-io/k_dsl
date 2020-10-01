# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Resources::JsonResource do
  subject { resource }

  let(:resource) do
    KDsl::Resources::Resource.instance(
      project: project,
      file: file
  )
  end

  let(:project) { KDsl::Manage::Project.new('sample') }
  let(:gem_root) { Gem::Specification.find_by_name("k_dsl").gem_dir }
  let(:file) { File.join(gem_root, 'spec/factories/dsls/data_files/sample.json') }

  describe '#instance' do
    it { is_expected.to have_attributes(file: file, type: described_class::TYPE_JSON) }
  end

  describe '.data' do
    subject { resource.data }

    it { is_expected.to be_nil }

    context '#load' do
      before { resource.load }

      it { is_expected.not_to be_nil }
      it do
        expect(subject).to have_attributes(
          name: 'David',
          age: 32,
          contact: have_attributes(
            phone: '0424 111 222',
            email: 'david@david.com',
            address: have_attributes(street: '32 Main St', suburb: 'Sydney')),
          skills: include(
            have_attributes( name: 'javascript', proficiency: 'ok'),
            have_attributes( name: 'ruby', proficiency: 'good')
          )
        )
      end

      it do
        resource.debug
      end
    end
  end
end
