# frozen_string_literal: true

require 'spec_helper'

RSpec.describe KDsl::TemplateRendering::HandlebarsHelper do
  
    let(:data) { { name: 'David' } }
    let(:subject) { KDsl::TemplateRendering::TemplateHelper.process_template(template, data) }
  
    describe 'basic template' do
      context 'process template' do
        let(:template) { '{{name}} was here' }
  
        it { expect(subject).to include('David was here') }
      end
  
      context 'safe helper' do
        let(:template) { '{{safe}}' }
  
        it { expect(subject).to include('<pre>Totally Safe!<pre>') }
      end
    end
  
    describe 'format symbles' do
  
      let(:data) { 
        { 
          name1: :activity, 
          name2: :achievement_badge, 
          name3: 'Hello World', 
          name4: 'the quick brown fox',
          name5: 'space   man',
          name6: '  spaced out   '
        } 
      }
  
      context 'snake' do
        let(:template) { '{{snake name1}} {{snake name2}} {{snake name3}} {{snake name4}} {{snake name5}} {{snake name6}}' }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('achievement_badge') }
        it { expect(subject).to include('hello_world') }
        it { expect(subject).to include('the_quick_brown_fox') }
        it { expect(subject).to include('space_man') }
        it { expect(subject).to include('spaced_out') }
      end
  
      context 'dashify' do
        let(:template) { '{{dashify name1}} {{dashify name2}} {{dashify name3}} {{dashify name4}} {{dashify name5}} {{dashify name6}}' }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('achievement-badge') }
        it { expect(subject).to include('hello-world') }
        it { expect(subject).to include('the-quick-brown-fox') }
        it { expect(subject).to include('space-man') }
        it { expect(subject).to include('spaced-out') }
      end
  
      context 'camel (aka camelU, camelUpper)' do
        let(:template) { '{{camel name1}} {{camelU name2}} {{camelUpper name3}} {{camel name4}} {{camelU name5}} {{camelUpper name6}}' }
  
        it { expect(subject).to include('Activity') }
        it { expect(subject).to include('AchievementBadge') }
        it { expect(subject).to include('HelloWorld') }
        it { expect(subject).to include('TheQuickBrownFox') }
        it { expect(subject).to include('SpaceMan') }
        it { expect(subject).to include('SpacedOut') }
      end
  
      context 'lamel (aka camelL, camelLower)' do
        let(:template) { '{{lamel name1}} {{camelL name2}} {{camelLower name3}} {{lamel name4}} {{camelL name5}} {{camelLower name6}}' }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('achievementBadge') }
        it { expect(subject).to include('helloWorld') }
        it { expect(subject).to include('theQuickBrownFox') }
        it { expect(subject).to include('spaceMan') }
        it { expect(subject).to include('spacedOut') }
      end
  
      context 'titleize' do
        let(:template) { '{{titleize name1}} {{titleize name2}} {{titleize name3}} {{titleize name4}} {{titleize name5}} {{titleize name6}}' }
  
        it { expect(subject).to include('Activity') }
        it { expect(subject).to include('Achievement Badge') }
        it { expect(subject).to include('Hello World') }
        it { expect(subject).to include('The Quick Brown Fox') }
        it { expect(subject).to include('Space Man') }
        it { expect(subject).to include('Spaced Out') }
      end
  
      context 'humanize' do
        let(:template) { '{{humanize name1}} {{humanize name2}} {{humanize name3}} {{humanize name4}} {{humanize name5}} {{humanize name6}}' }
  
        it { expect(subject).to include('Activity') }
        it { expect(subject).to include('Achievement badge') }
        it { expect(subject).to include('Hello world') }
        it { expect(subject).to include('The quick brown fox') }
        it { expect(subject).to include('Space man') }
        it { expect(subject).to include('Spaced out') }
      end
  
      context 'constant' do
        let(:template) { '{{constantize name1}} {{constant name2}} {{constant name3}} {{constant name4}} {{constant name5}} {{constant name6}}' }
  
        it { expect(subject).to include('ACTIVITY') }
        it { expect(subject).to include('ACHIEVEMENT_BADGE') }
        it { expect(subject).to include('HELLO_WORLD') }
        it { expect(subject).to include('THE_QUICK_BROWN_FOX') }
        it { expect(subject).to include('SPACE_MAN') }
        it { expect(subject).to include('SPACED_OUT') }
      end
  
      context 'humanize, then pluralize' do
        let(:template) { '{{pluralize (humanize name1)}} {{pluralize (humanize name2)}} {{pluralize (humanize name3)}} {{pluralize (humanize name4)}} {{pluralize (humanize name5)}} {{pluralize (humanize name6)}}' }
  
        it { expect(subject).to include('Activities') }
        it { expect(subject).to include('Achievement badges') }
        it { expect(subject).to include('Hello worlds') }
        it { expect(subject).to include('The quick brown foxes') }
        it { expect(subject).to include('Space men') }
        it { expect(subject).to include('Spaced outs') }
      end
    end
  
    describe 'common helpers' do
  
      let(:data) { {} }
  
      context 'default' do
        let(:data) { { name1: :activity } }
        let(:template) { "{{default name1 'override name1'}} {{default unknown 'override unknown'}} {{default unknown '<pre>unkown as html</pre>'}}" }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('override unknown') }
        it { expect(subject).to include('<pre>unkown as html</pre>') }
      end
  
      context 'curly-open' do
        let(:template) { "{{curly-open}} - {{curly-open 1}} - {{curly-open 4}}" }
  
        it { expect(subject).to include('{ - { - {{{{') }
      end
  
      context 'curly_open' do
        let(:template) { "{{curly_open 2}}" }
  
        it { expect(subject).to include('{{') }
      end
  
      context 'curly-close' do
        let(:template) { "The quick brown {{animal}} jumped {{curly-close}} - {{curly-close 1}} - {{curly-close 4}}" }
  
        it { expect(subject).to include('} - } - }}}}') }
      end
  
      context 'curly_close' do
        let(:template) { "{{curly_close 2}}" }
  
        it { expect(subject).to include('}}') }
      end
    end
  
    describe 'ifx conditional helper' do
      context '==' do
        let(:template) { "{{#ifx 'David' '==' name}}yes{{else}}no{{/ifx}}" }
      
        context 'when case-sensistive equal' do
          let(:data) { { name: 'David' } }
          it { is_expected.to include('yes')}
        end
  
        context 'when case-insensitive equal' do
          let(:data) { { name: 'DAVID' } }
          it { is_expected.to include('yes')}
        end
  
        context 'when not equal' do
          let(:data) { { name: 'Bob' } }
          it { is_expected.to include('no')}
        end
      end
  
      context '<' do
        let(:template) { "{{#ifx 10 '<' count}}yes{{else}}no{{/ifx}}" }
      
        context 'true' do
          let(:data) { { count: 11 } }
          it { is_expected.to include('yes')}
        end
  
        context 'false' do
          let(:data) { { count: 10 } }
          it { is_expected.to include('no')}
        end
      end
  
      context '<=' do
        let(:template) { "{{#ifx 10 '<=' count}}yes{{else}}no{{/ifx}}" }
      
        context 'true' do
          let(:data) { { count: 10 } }
          it { is_expected.to include('yes')}
        end
  
        context 'false' do
          let(:data) { { count: 9 } }
          it { is_expected.to include('no')}
        end
      end
  
      context '>' do
        let(:template) { "{{#ifx 10 '>' count}}yes{{else}}no{{/ifx}}" }
      
        context 'true' do
          let(:data) { { count: 9 } }
          it { is_expected.to include('yes')}
        end
  
        context 'false' do
          let(:data) { { count: 10 } }
          it { is_expected.to include('no')}
        end
      end
  
      context '>=' do
        let(:template) { "{{#ifx 10 '>=' count}}yes{{else}}no{{/ifx}}" }
      
        context 'true' do
          let(:data) { { count: 10 } }
          it { is_expected.to include('yes')}
        end
  
        context 'false' do
          let(:data) { { count: 11 } }
          it { is_expected.to include('no')}
        end
      end
  
    end
  
  end
  