# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl do

  before { KDsl.teardown }

  # describe '#log_level' do
  #   subject { described_class.project_manager }

  #   it { is_expected.to be_nil }

  #   context 'after setup' do
  #     before { KDsl.setup }
      
  #     it { is_expected.not_to be_nil }
  #   end
  # end

  describe '.project_manager' do
    subject { described_class.project_manager }

    it { is_expected.to be_nil }

    context 'when setup' do
      before { KDsl.setup }
      
      it { is_expected.not_to be_nil }
      it { is_expected.to be_a(KDsl::Manage::ProjectManager) }
    end
  end

  describe '.target_resource' do
    subject { described_class.target_resource }

    it { is_expected.to be_nil }

    context 'when registering a resource' do
      # before { KDsl.setup }
      
      # it { is_expected.not_to be_nil }
      # it { is_expected.to be_a(KDsl::Manage::ProjectManager) }
    end
  end

  describe '.log_level' do
    subject { described_class.log_level }

    it { is_expected.to be_nil }

    context 'when setup' do
      before { KDsl.setup }
      
      it { is_expected.to eq(:none) }

      context 'with log_level' do
        subject { described_class }

        before { KDsl.setup(log_level: log_level) }

        context ':none' do
          let(:log_level) { :none }
          it { is_expected.to be_log_none }
        end

        context ':warn' do
          let(:log_level) { :warn }
          it { is_expected.to be_log_warn }
        end

        context ':info' do
          let(:log_level) { :info }
          it { is_expected.to be_log_info }
        end
      end
    end
  end

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
        context 'when key is symbol' do
          let(:key) { :my_key }

          it { expect(subject.key).to eq(:my_key) }
        end
      end
    end
  end
end
