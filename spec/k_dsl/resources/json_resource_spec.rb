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

  describe 'project.resource_documents' do
    subject { project.resource_documents }

    it { is_expected.to be_empty }

    context '#register' do
      before do
        resource.load_content
        resource.register
      end

      it { is_expected.not_to be_empty }

      it 'has one document with data' do
        expect(subject.length).to eq 1
        expect(subject.first.data).to eq({})
        # subject.first.document.debug(true)
      end

      it 'has key' do
        expect(subject.first.key).to eq('sample.json')
      end

      it 'has type' do
        expect(subject.first.type).to eq('json')
      end

      context '#load' do
        before { resource.load }

        it { is_expected.not_to be_nil }

        it 'has one document with data' do
          expect(subject.length).to eq 1
          expect(subject.first.data).to include(
            'name' => 'David',
            'age' => 32,
            'contact' => {
              'phone' => '0424 111 222',
              'email' => 'david@david.com',
              'address' => { 'street' => '32 Main St', 'suburb' => 'Sydney' }
            },
            'skills' => [
              { 'name' => 'javascript', 'proficiency' => 'ok' },
              { 'name' => 'ruby', 'proficiency' => 'good' }
            ]
          )
        end

        # it do
        #   resource.debug
        # end
      end

    end
  end
end
