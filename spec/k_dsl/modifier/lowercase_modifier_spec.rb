# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Modifier::LowercaseModifier do
  subject { described_class.new.update(data) }

  describe '#update' do
    let(:data) do
      {
        the: 'Quick',
        'brown' => :Fox,
        had_friends: 5
      }
    end

    it { is_expected.to include(the: 'quick', 'brown' => 'fox', had_friends: 5) }
  end
end
