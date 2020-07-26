# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl do
  describe '#document' do
    context 'with no arguments' do
      subject { described_class.document }

      it { is_expected.not_to be_nil }

      describe '.key' do
        it { expect(subject.key).not_to be_nil }
        it { expect(subject.key).to be_a(String) }
        it 'looks like a guid' do
          expect(subject.key.length).to eq(36)
        end
      end
      describe '.type' do
        it { expect(subject.type).not_to be_empty }
      end
      describe '.namespace' do
        it { expect(subject.namespace).to be_empty }
      end
    end

    context 'with key' do
      subject { described_class.document(key) }

      describe '.key' do
        context 'when key is string' do
          let(:key) { 'my_key' }

          it { expect(subject.key).to eq('my_key') }
        end
        # MAY REFACTOR - Should a symbol just turn into a string, think about this
        context 'when key is symbol' do
          let(:key) { :my_key }

          it { expect(subject.key).to eq(:my_key) }
        end
      end
    end
  end
end
