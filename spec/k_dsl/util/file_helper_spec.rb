# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Util::FileHelper do
  describe '#pathname_absolute?' do
    subject { described_class.pathname_absolute?(file) }

    context 'when filename only' do
      let(:file) { 'somefile.rb' }

      it { is_expected.to be_falsey }
    end

    context 'when relative path / filename' do
      let(:file) { 'somepath/somefile.rb' }

      it { is_expected.to be_falsey }
    end

    context 'when absolute file' do
      let(:file) { '/somefile.rb' }

      it { is_expected.to be_truthy }
    end

    context 'when tilda expanded file' do
      let(:file) { '~/somefile.rb' }

      it { is_expected.to be_falsey }
    end
  end

  describe '#pathname_absolute?' do
    subject { described_class.expand_path(file, '/klue-less/xyz') }

    context 'when relative filename' do
      let(:file) { 'somefile.rb' }

      it { is_expected.to eq('/klue-less/xyz/somefile.rb')}
    end

    context 'when relative path/filename' do
      let(:file) { 'somepath/somefile.rb' }

      it { is_expected.to eq('/klue-less/xyz/somepath/somefile.rb')}
    end

    context 'when absolute filename' do
      let(:file) { '/somefile.rb' }

      it { is_expected.to eq('/somefile.rb')}
    end

    context 'when tilda ~/filename' do
      let(:file) { '~/somefile.rb' }

      it { is_expected.to start_with('/Users') & end_with('/somefile.rb') }
      it { is_expected.not_to include('klue-less') }
    end
  end
end
