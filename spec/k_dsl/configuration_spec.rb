# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl do
  describe '#config' do
    subject { described_class.config }

    context 'has instance' do
      it { is_expected.not_to be_nil }
    end
  end

  describe '#configuration' do
    context '.default_document_type' do
      subject { described_class.config.default_document_type }

      it { is_expected.to eq(:entity) }
    end

    context '.default_settings_key' do
      subject { described_class.config.default_settings_key }

      it { is_expected.to eq(:settings) }
    end

    context '.default_table_key' do
      subject { described_class.config.default_table_key }

      it { is_expected.to eq(:table) }
    end

    # context '.document_class' do
    #   subject { described_class.config.document_class }

    #   it { is_expected.to eq(KDsl::Model::Document) }
    # end

    # context '.table_class' do
    #   subject { described_class.config.table_class }

    #   it { is_expected.to eq(KDsl::Model::Table) }
    # end

    # context '.settings_class' do
    #   subject { described_class.config.settings_class }

    #   it { is_expected.to eq(KDsl::Model::Settings) }
    # end

    context '.decorators' do
      subject { described_class.config.decorators }

      it { is_expected.to be_an(Hash) }
      it { is_expected.to include(:uppercase) }
      it { is_expected.to include(:lowercase) }
    end
  end

  describe '#get_decorator' do
    subject { described_class.config.get_decorator(key) }

    context 'when valid key' do
      let(:key) { :uppercase }

      it { is_expected.not_to be_nil }
    end
  end
end
