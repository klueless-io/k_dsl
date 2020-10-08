# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Util::DslHelper do
  describe 'module helper' do
    subject { KDsl::Util.dsl }

    it { is_expected.not_to be_nil }

    it { expect(subject.build_unique_key('key', 'type', 'namespace')).to eq('namespace_key_type') }
  end

  describe '#build_unique_key' do
    subject { described_class.build_unique_key(key, nil, namespace) }

    let(:key) { nil }
    let(:namespace) { nil }

    context 'with nil key' do
      it { expect { subject }.to raise_error KDsl::Error }
    end

    context 'with key' do
      let(:key) { 'some_name' }

      it { is_expected.to eq('some_name_entity') }

      context 'containing a space' do
        let(:key) { 'some name' }

        it { expect(subject).to eq("some name_#{KDsl.config.default_document_type}") }
      end

      context 'with namespace' do
        let(:namespace) { :spaceman }

        it { expect(subject).to eq("spaceman_some_name_#{KDsl.config.default_document_type}") }
      end

      context 'with type' do
        subject { described_class.build_unique_key(key, type, namespace) }

        context 'nil' do
          let(:type) { nil }

          it { expect(subject).to eq("some_name_#{KDsl.config.default_document_type}") }
        end

        context 'controller' do
          let(:type) { :controller }

          it { expect(subject).to eq('some_name_controller') }

          context 'and with namespace' do
            let(:namespace) { :spaceman }

            it { expect(subject).to eq('spaceman_some_name_controller') }
          end
        end
      end
    end
  end
end
