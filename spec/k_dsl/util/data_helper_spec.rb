# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Util::DataHelper do
  describe 'module helper' do
    subject { KDsl::Util.data }

    it { is_expected.not_to be_nil }

    # it { expect(subject.build_unique_key('key', 'type', 'namespace')).to eq('namespace_key_type') }
  end

  describe '#to_struct' do
    subject { described_class.to_struct(data) }

      # it { expect { subject }.to raise_error KDsl::Error }
      context 'when simple hash' do
        let(:data) { { key1: 'David', key2: 333 } }
  
        it { is_expected.to have_attributes(key1: 'David', key2: 333) }
      end
      context 'when array of hash' do
        let(:data) { { items: [{id: 1, name: 'Item1'}, {id: 2, name: 'Item2'}] } }
  
        it do
          expect(subject).to have_attributes(
            items: array_including(
              have_attributes(id: 1, name: 'Item1'),
              have_attributes(id: 2, name: 'Item2')
              )
          )
        end
      end
      context 'when complex hash' do
        let(:data) { { key1: 'David', key2: 333, items: [{id: 1, name: 'Item1'}, {id: 2, name: 'Item2'}] } }
  
        it do
          expect(subject).to have_attributes(
            key1: 'David',
            key2: 333,
            items: array_including(
              have_attributes(id: 1, name: 'Item1'),
              have_attributes(id: 2, name: 'Item2')
              )
          )
        end
      end
    end
end