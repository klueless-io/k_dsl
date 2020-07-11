# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::Modifier::Processor do
  let(:instance) { described_class.new }

  describe '#modifiers' do
    subject { instance.modifiers(modifier_types) }

    context 'when modifier types is nil' do
      let(:modifier_types) { nil }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end

    context 'when given a list of pre-configured symbols' do
      let(:modifier_types) { %i[uppercase lowercase] }

      it { is_expected.to be_an(Array) }
      it { expect(subject.length).to eq 2 }

      context 'but a symbol is unknown' do
        let(:modifier_types) { %i[uppercase xmen] }

        it { expect(subject.length).to eq 1 }
      end
    end

    context 'when given a list of pre-defined classes' do
      let(:modifier_types) { [X, Y] }

      it { is_expected.to be_an(Array) }
      it { expect(subject.length).to eq 2 }

      context 'but a class does not respond to update' do
        let(:modifier_types) { [X, NoUpdate] }

        it { expect(subject.length).to eq 1 }
      end
    end

    context 'when given a list of lambda expression' do
      let(:lambda) { -> {} }
      let(:modifier_types) { [lambda] }

      it { is_expected.to be_an(Array) }
      it { expect(subject.length).to eq 1 }
    end
  end

  describe '#modify_settings' do
    subject { instance.modify_settings(modifiers, settings) }

    let(:modifiers) { instance.modifiers(modifier_types) }
    let(:modifier_types) { nil }
    let(:settings) { nil }
    let(:lambda) { ->(hash) { hash.update(hash) { |_k, v| "[#{v}]" } } }

    context 'when data settings are nil' do
      it { is_expected.to be_nil }
    end

    context 'with data' do
      let(:settings) do
        {
          the: 'Quick',
          'brown' => :Fox,
          had_friends: 5
        }
      end

      context 'when using pre-configured uppercase' do
        let(:modifier_types) { %i[uppercase] }

        it { is_expected.to include(the: 'QUICK', 'brown' => 'FOX', had_friends: 5) }

        context 'followed by lowercase' do
          let(:modifier_types) { %i[uppercase lowercase] }

          it { is_expected.to include(the: 'quick') }
        end
      end

      context 'when using pre-defined class X' do
        let(:modifier_types) { [X] }

        it { is_expected.to include(the: 'Quick', 'brown' => :Fox, had_friends: 5, x: 'xxxx') }

        context 'and uppercase' do
          let(:modifier_types) { [X, :uppercase] }

          it { is_expected.to include(the: 'QUICK', 'brown' => 'FOX', had_friends: 5, x: 'XXXX') }
        end
      end

      context 'when using lambda' do
        let(:modifier_types) { [lambda] }

        it { is_expected.to include(the: '[Quick]', 'brown' => '[Fox]', had_friends: '[5]') }
      end

      context 'when [X, :uppercase, Y, lambda' do
        let(:modifier_types) { [X, :uppercase, Y, lambda] }

        it { is_expected.to include(the: '[QUICK yyyy]', 'brown' => '[FOX yyyy]', had_friends: '[5 yyyy]', x: '[XXXX yyyy]') }
      end
    end
  end

  class X
    def update(data)
      data[:x] = 'xxxx'
    end
  end
  class Y
    def update(data)
      data.update(data) { |k, v| data[k] = "#{v} yyyy" }
    end
  end
  class NoUpdate
  end
end
