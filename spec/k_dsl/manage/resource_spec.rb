# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Manage::Resource do
  subject { described_class.new(type, full_path) }

  let(:type) { described_class::TYPE_DSL }
  let(:full_path) { '/somepath/file.rb' }

  describe '#constructor' do
    it { is_expected.to have_attributes(type: 'dsl', full_path: '/somepath/file.rb') }
  end
end
