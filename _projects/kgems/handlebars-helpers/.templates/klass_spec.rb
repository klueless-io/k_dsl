# frozen_string_literal: true

require 'handlebars/helpers/{{snake blueprint.settings.name}}'

RSpec.describe Handlebars::Helpers::{{camel blueprint.settings.name}} do
  let(:subject) { described_class.new }

  it { is_expected.not_to be_nil }

  describe '#method' do
    subject { described_class.new.method(value) }

    let(:value) { value }

    it { is_expected.to eq('some_value') }
  end
end
