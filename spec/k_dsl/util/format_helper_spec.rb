# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Util::FileHelper do
  let(:instance) { KDsl::Util.format }
  let(:value) { 'the quick brown fox' }

  describe 'module helper' do
    subject { instance }

    it { is_expected.not_to be_nil }
  end

  describe '#snake' do
    subject { instance.snake(value) }

    it { is_expected.to eq('the_quick_brown_fox') }
  end

  describe '#dashify' do
    subject { instance.dashify(value) }

    it { is_expected.to eq('the-quick-brown-fox') }
  end

  describe '#camel' do
    subject { instance.camel(value) }

    it { is_expected.to eq('TheQuickBrownFox') }
  end

  describe '#lamel' do
    subject { instance.lamel(value) }

    it { is_expected.to eq('theQuickBrownFox') }
  end

  describe '#titleize' do
    subject { instance.titleize(value) }

    it { is_expected.to eq('The Quick Brown Fox') }
  end

  describe '#humanize' do
    subject { instance.humanize(value) }

    it { is_expected.to eq('The quick brown fox') }
  end

  describe '#constantize' do
    subject { instance.constantize(value) }

    it { is_expected.to eq('THE_QUICK_BROWN_FOX') }
  end
end
