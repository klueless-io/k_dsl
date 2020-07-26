# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl do
  describe '#manager' do
    subject { described_class.manager }

    context 'has instance' do
      it { is_expected.not_to be_nil }
    end
  end
end
