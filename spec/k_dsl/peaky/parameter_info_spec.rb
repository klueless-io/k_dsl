# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Peaky::ParameterInfo do
  subject { instance }

  let(:instance) { described_class.new }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      # it { is_expected.to have_attributes()}
    end
  end

  describe '#parameter_info' do
    subject { obj.parameter_info(params).first}
    context 'with attribute writer signature' do
      let(:params) { [[:req]] }
      it '' do puts subject; end

      it { is_expected.to include(name: '', type: :param_required, signature_format: '', minimal_call_format: "''" ) }
    end

    context 'with required positional parameter - my_method(aaa)' do
      let(:params) { [[:req,'aaa']] }

      it { is_expected.to include(name: 'aaa', type: :param_required, signature_format: "aaa", minimal_call_format: "'aaa'" ) }
    end

    context 'with optional positioned parameter - my_method(aaa = nil)' do
      let(:params) { [[:opt,'aaa']] }

      it { is_expected.to include(name: 'aaa', type: :param_optional, signature_format: "aaa = nil", minimal_call_format: '' ) }
    end

    context 'with splat positioned parameters - my_method(*aaa)' do
      let(:params) { [[:rest,'aaa']] }

      it { is_expected.to include(name: 'aaa', type: :splat, signature_format: "*aaa", minimal_call_format: '' ) }
    end

    context "with required keyed/named parameter - my_method(aaa: 'aaa')" do
      let(:params) { [[:keyreq,'aaa']] }

      it { is_expected.to include(name: 'aaa', type: :key_required, signature_format: "aaa:", minimal_call_format: "aaa: 'aaa'" ) }
    end

    context 'with optional keyed/named parameter - my_method(aaa: nil)' do
      let(:params) { [[:key,'aaa']] }

      it { is_expected.to include(name: 'aaa', type: :key_optional, signature_format: "aaa: nil", minimal_call_format: '' ) }
    end

    context 'with optional keyed/named parameter - my_method(&aaa)' do
      let(:params) { [[:block,'aaa']] }

      it { is_expected.to include(name: 'aaa', type: :block, signature_format: "&aaa", minimal_call_format: '' ) }
    end
  end

end
