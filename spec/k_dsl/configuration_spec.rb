# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl do #::Configuration do
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

    context '.default_rows_key' do
      subject { described_class.config.default_rows_key }

      it { is_expected.to eq(:rows) }
    end
  end
end
