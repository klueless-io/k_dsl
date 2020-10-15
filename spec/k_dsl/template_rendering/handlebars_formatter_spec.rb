# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::TemplateRendering::HandlebarsFormatter do

  describe 'format symbols' do

    let(:name1) { 'activity' }
    let(:name2) { 'achievement_badge' }
    let(:name3) { 'Hello World' }
    let(:name4) { 'the quick brown fox' }
    let(:name5) { 'space   man' }
    let(:name6) { '  spaced out   ' }

    context 'snake' do

      it { expect(described_class.snake(name1)).to eq('activity') }
      it { expect(described_class.snake(name2)).to eq('achievement_badge') }
      it { expect(described_class.snake(name3)).to eq('hello_world') }
      it { expect(described_class.snake(name4)).to eq('the_quick_brown_fox') }
      it { expect(described_class.snake(name5)).to eq('space_man') }
      it { expect(described_class.snake(name6)).to eq('spaced_out') }

    end

    context 'dashify' do

      it { expect(described_class.dashify(name1)).to eq('activity') }
      it { expect(described_class.dashify(name2)).to eq('achievement-badge') }
      it { expect(described_class.dashify(name3)).to eq('hello-world') }
      it { expect(described_class.dashify(name4)).to eq('the-quick-brown-fox') }
      it { expect(described_class.dashify(name5)).to eq('space-man') }
      it { expect(described_class.dashify(name6)).to eq('spaced-out') }

    end

    context 'camel' do

      it { expect(described_class.camel(name1)).to eq('Activity') }
      it { expect(described_class.camel(name2)).to eq('AchievementBadge') }
      it { expect(described_class.camel(name3)).to eq('HelloWorld') }
      it { expect(described_class.camel(name4)).to eq('TheQuickBrownFox') }
      it { expect(described_class.camel(name5)).to eq('SpaceMan') }
      it { expect(described_class.camel(name6)).to eq('SpacedOut') }

    end

    context 'lamel' do

      it { expect(described_class.lamel(name1)).to eq('activity') }
      it { expect(described_class.lamel(name2)).to eq('achievementBadge') }
      it { expect(described_class.lamel(name3)).to eq('helloWorld') }
      it { expect(described_class.lamel(name4)).to eq('theQuickBrownFox') }
      it { expect(described_class.lamel(name5)).to eq('spaceMan') }
      it { expect(described_class.lamel(name6)).to eq('spacedOut') }

    end

    context 'titleize' do

      it { expect(described_class.titleize(name1)).to eq('Activity') }
      it { expect(described_class.titleize(name2)).to eq('Achievement Badge') }
      it { expect(described_class.titleize(name3)).to eq('Hello World') }
      it { expect(described_class.titleize(name4)).to eq('The Quick Brown Fox') }
      it { expect(described_class.titleize(name5)).to eq('Space Man') }
      it { expect(described_class.titleize(name6)).to eq('Spaced Out') }

    end

    context 'humanize' do

      it { expect(described_class.humanize(name1)).to eq('Activity') }
      it { expect(described_class.humanize(name2)).to eq('Achievement badge') }
      it { expect(described_class.humanize(name3)).to eq('Hello world') }
      it { expect(described_class.humanize(name4)).to eq('The quick brown fox') }
      it { expect(described_class.humanize(name5)).to eq('Space man') }
      it { expect(described_class.humanize(name6)).to eq('Spaced out') }

    end

    context 'constantize' do

      it { expect(described_class.constantize(name1)).to eq('ACTIVITY') }
      it { expect(described_class.constantize(name2)).to eq('ACHIEVEMENT_BADGE') }
      it { expect(described_class.constantize(name3)).to eq('HELLO_WORLD') }
      it { expect(described_class.constantize(name4)).to eq('THE_QUICK_BROWN_FOX') }
      it { expect(described_class.constantize(name5)).to eq('SPACE_MAN') }
      it { expect(described_class.constantize(name6)).to eq('SPACED_OUT') }

    end

  end

  describe 'common helpers' do

    context 'default' do
      let(:name) { 'activity' }
      let(:xyz) {  }

      it { expect(described_class.default(name, 'override name1')).to eq('activity') }
      it { expect(described_class.default(xyz, 'override unknown')).to eq('override unknown') }
    end

    context 'curly_open' do
      it { expect(described_class.curly_open).to include('{') }
      it { expect(described_class.curly_open(1)).to include('{') }
      it { expect(described_class.curly_open(4)).to include('{{{{') }
    end

    context 'curly_close' do
      it { expect(described_class.curly_close).to include('}') }
      it { expect(described_class.curly_close(1)).to include('}') }
      it { expect(described_class.curly_close(4)).to include('}}}}') }
    end

  end

  describe 'logic helpers' do
    let(:lhs) { nil }
    let(:rhs) { nil }

    # Example 1
    #
    # {{#if (or section1 section2)}}
    # .. content
    # {{/if}}
    # Example 2
    #
    # {{#if (or 
    #     (eq section1 "foo")
    #     (ne section2 "bar"))}}
    # .. content
    # {{/if}}

    context 'or' do
      subject { described_class.or(lhs, rhs)}
      context 'nil || nil' do
        it { is_expected.to be_falsey }
      end
      context 'data || nil' do
        let(:lhs) { 'data' }
        it { is_expected.to be_truthy }
      end
      context 'nil || data' do
        let(:rhs) { 'data' }
        it { is_expected.to be_truthy }
      end
      context 'data || data' do
        let(:lhs) { 'data' }
        let(:rhs) { 'data' }
        it { is_expected.to be_truthy }
      end
    end

    context 'and' do
      subject { described_class.and(lhs, rhs)}
      context 'nil && nil' do
        it { is_expected.to be_falsey }
      end
      context 'data && nil' do
        let(:lhs) { 'data' }
        it { is_expected.to be_falsey }
      end
      context 'nil && data' do
        let(:rhs) { 'data' }
        it { is_expected.to be_falsey }
      end
      context 'data && data' do
        let(:lhs) { 'data' }
        let(:rhs) { 'data' }
        it { is_expected.to be_truthy }
      end
    end

    context 'eq' do
      subject { described_class.and(lhs, rhs)}
      context 'nil == nil' do
        it { is_expected.to be_falsey }
      end
      context 'data == nil' do
        let(:lhs) { 'data' }
        it { is_expected.to be_falsey }
      end
      context 'nil == data' do
        let(:rhs) { 'data' }
        it { is_expected.to be_falsey }
      end
      context 'data == data' do
        let(:lhs) { 'data' }
        let(:rhs) { 'data' }
        it { is_expected.to be_truthy }
      end
    end

    context 'ne' do
      subject { described_class.ne(lhs, rhs)}
      context 'nil != nil' do
        it { is_expected.to be_falsey }
      end
      context 'data != nil' do
        let(:lhs) { 'data' }
        it { is_expected.to be_truthy }
      end
      context 'nil != data' do
        let(:rhs) { 'data' }
        it { is_expected.to be_truthy }
      end
      context 'data != data' do
        let(:lhs) { 'data' }
        let(:rhs) { 'data' }
        it { is_expected.to be_falsey }
      end
    end

    context 'lt' do
      subject { described_class.lt(lhs, rhs)}
      context 'as number' do
        let(:lhs) { 1 }
        let(:rhs) { 1 }

        context '1 < 1' do
          it { is_expected.to be_falsey }
        end
        context '0 < 1' do
          let(:lhs) { 0 }
          it { is_expected.to be_truthy }
        end
      end
      context 'as string' do
        let(:lhs) { 'b' }
        let(:rhs) { 'b' }

        context 'b < b' do
          it { is_expected.to be_falsey }
        end
        context 'a < b' do
          let(:lhs) { 'a' }
          it { is_expected.to be_truthy }
        end
      end
    end

    context 'lte' do
      subject { described_class.lte(lhs, rhs)}
      context 'as number' do
        let(:lhs) { 1 }
        let(:rhs) { 1 }

        context '1 <= 1' do
          it { is_expected.to be_truthy }
        end
        context '0 <= 1' do
          let(:lhs) { 0 }
          it { is_expected.to be_truthy }
        end
        context '2 <= 1' do
          let(:lhs) { 2 }
          it { is_expected.to be_falsey }
        end
      end
      context 'as string' do
        let(:lhs) { 'b' }
        let(:rhs) { 'b' }

        context 'b <= b' do
          it { is_expected.to be_truthy }
        end
        context 'a <= b' do
          let(:lhs) { 'a' }
          it { is_expected.to be_truthy }
        end
        context 'c <= b' do
          let(:lhs) { 'c' }
          it { is_expected.to be_falsey }
        end
      end
    end

    
    context 'gt' do
      subject { described_class.gt(lhs, rhs)}
      context 'as number' do
        let(:lhs) { 1 }
        let(:rhs) { 1 }

        context '1 > 1' do
          it { is_expected.to be_falsey }
        end
        context '2 > 1' do
          let(:lhs) { 2 }
          it { is_expected.to be_truthy }
        end
      end
      context 'as string' do
        let(:lhs) { 'b' }
        let(:rhs) { 'b' }

        context 'b > b' do
          it { is_expected.to be_falsey }
        end
        context 'b > a' do
          let(:rhs) { 'a' }
          it { is_expected.to be_truthy }
        end
      end
    end

    context 'gte' do
      subject { described_class.gte(lhs, rhs)}
      context 'as number' do
        let(:lhs) { 1 }
        let(:rhs) { 1 }

        context '1 >= 1' do
          it { is_expected.to be_truthy }
        end
        context '0 >= 1' do
          let(:lhs) { 0 }
          it { is_expected.to be_falsey }
        end
        context '2 >= 1' do
          let(:lhs) { 2 }
          it { is_expected.to be_truthy }
        end
      end
      context 'as string' do
        let(:lhs) { 'b' }
        let(:rhs) { 'b' }

        context 'b >= b' do
          it { is_expected.to be_truthy }
        end
        context 'c >= b' do
          let(:lhs) { 'c' }
          it { is_expected.to be_truthy }
        end
        context 'a >= b' do
          let(:lhs) { 'a' }
          it { is_expected.to be_falsey }
        end
      end
    end

  end

end
