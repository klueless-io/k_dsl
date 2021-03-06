# frozen_string_literal: true

require 'spec_helper'

# rubocop:disable Metrics/ParameterLists
class A1
  def simple(first_param); end

  def complex(aaa, bbb = 1, *ccc, ddd:, eee: 1, **fff, &ggg); end
end
# rubocop:enable Metrics/ParameterLists

RSpec.describe Peeky{{prefix_if_value blueprint.settings.output_rel_path '::' 'camel'}}::{{camel blueprint.settings.name}} do
  subject { instance }

  let(:instance) { described_class.new(method_signature) }
  let(:method_signature) { Peeky::MethodSignature.new(method) }
  let(:method) { target_instance.method(method_name) }
  let(:target_instance) { A1.new }
  let(:method_name) { :simple }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
    end
  end

  describe '#render' do
    subject { instance.render }

    # it { is_expected.to start_with('') }

    # context 'when complex method' do
    #   let(:method_name) { :complex }

    #   it { is_expected.to start_with('') }
    # end
  end

  describe '#debug' do
    subject { instance.debug }
    # it { is_expected } # uncomment to print debug content
  end
end
