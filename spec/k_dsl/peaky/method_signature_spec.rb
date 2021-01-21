# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Peaky::MethodSignature do
  subject { obj }

  class A
    attr_accessor :a
    attr_reader   :b
    attr_writer   :c

    def d;                                  end
    def e(a);                               end
    def f(a, b = 1);                        end
    def g(a, b = 1, c = 2);                 end
    def h(*a);                              end
    def i(a, b, *c);                        end
    def j(**a);                             end
    def k(a, *b, **c);                      end
    def l(a, *b, **c, &d);                  end
    def m(a:);                              end
    def n(a:, b: 1);                        end
    def p?;                                 end
    def z(a, b = 1, *c, d:, e: 1, **f, &g); end
  end

  let(:obj) { described_class.new(instance, instance_name: instance_name) }
  let(:instance) { A.new }
  let(:instance_name) { nil }

  describe '#constructor' do
    context 'with default parameters' do
      it { is_expected.not_to be_nil }
      it { is_expected.to have_attributes(instance: instance)}
      it { is_expected.to have_attributes(instance_name: 'a')}

      context 'with custom instance_name' do
        let(:instance_name) { 'my_instance' }
        it { is_expected.to have_attributes(instance_name: 'my_instance')}
      end
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
