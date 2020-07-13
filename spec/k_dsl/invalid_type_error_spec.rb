# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::InvalidTypeError do
  describe '#constructor' do
    context 'no params' do
      subject { described_class.new }

      it { is_expected.not_to be_nil }
    end

    context 'with error message' do
      subject { described_class.new('some message').message }

      it { is_expected.to eq('some message') }
    end
  end

  describe '#raise' do
    it { expect { raise described_class }.to raise_error(described_class) }
  end
end
