# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'KDsl::Decorator::Helper' do
  let(:instance) { KDsl::Decorator.decorate }

  describe '#decorators' do
    subject { instance.decorators(decorator_types) }

    context 'when decorator types is nil' do
      let(:decorator_types) { nil }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end

    context 'when given a list of pre-configured symbols' do
      let(:decorator_types) { %i[uppercase lowercase] }

      it { is_expected.to be_an(Array) }
      it { expect(subject.length).to eq 2 }

      context 'but a symbol is unknown' do
        let(:decorator_types) { %i[uppercase xmen] }

        it { expect(subject.length).to eq 1 }
      end
    end

    context 'when given a list of pre-defined classes' do
      let(:decorator_types) { [X, Y] }

      it { is_expected.to be_an(Array) }
      it { expect(subject.length).to eq 2 }

      context 'but a class does not respond to update' do
        let(:decorator_types) { [X, NoUpdate] }

        it { expect(subject.length).to eq 1 }
      end
    end

    context 'when given a list of lambda expression' do
      let(:lambda) { -> {} }
      let(:decorator_types) { [lambda] }

      it { is_expected.to be_an(Array) }
      it { expect(subject.length).to eq 1 }
    end
  end

  describe '#decorate_settings' do
    subject { instance.decorate_settings(decorators, settings) }

    let(:decorators) { instance.decorators(decorator_types) }
    let(:decorator_types) { nil }
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
        let(:decorator_types) { %i[uppercase] }

        it { is_expected.to include(the: 'QUICK', 'brown' => 'FOX', had_friends: 5) }

        context 'followed by lowercase' do
          let(:decorator_types) { %i[uppercase lowercase] }

          it { is_expected.to include(the: 'quick') }
        end
      end

      context 'when using pre-defined class X' do
        let(:decorator_types) { [X] }

        it { is_expected.to include(the: 'Quick', 'brown' => :Fox, had_friends: 5, x: 'xxxx') }

        context 'and uppercase' do
          let(:decorator_types) { [X, :uppercase] }

          it { is_expected.to include(the: 'QUICK', 'brown' => 'FOX', had_friends: 5, x: 'XXXX') }
        end
      end

      context 'when using lambda' do
        let(:decorator_types) { [lambda] }

        it { is_expected.to include(the: '[Quick]', 'brown' => '[Fox]', had_friends: '[5]') }
      end

      context 'when [X, :uppercase, Y, lambda' do
        let(:decorator_types) { [X, :uppercase, Y, lambda] }

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
