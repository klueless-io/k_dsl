# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Peeky{{prefix_if_value snake blueprint.settings.output_rel_path '::'}}::{{camel blueprint.settings.name}} do
  subject { instance }

  let(:instance) { described_class.new }

  describe '#constructor' do
    context 'factory class requires private method' do
      it { expect { described_class.new }.to raise_error NoMethodError }
    end
  end
end
