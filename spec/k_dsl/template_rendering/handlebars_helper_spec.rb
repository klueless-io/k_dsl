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
        let(:template) { '{{safe "<pre>Totally Safe!</pre>"}}' }
  
        it { expect(subject).to include('<pre>Totally Safe!</pre>') }
      end

      context 'raw helper' do
        let(:data) { { inside: 'David' } }
        let(:template) { '{{{{raw}}}}<p>Nothing {{ inside }} this block will be parsed as Handlebars.</p>{{{{/raw}}}}' }

        it { expect(subject).to include('<p>Nothing {{ inside }} this block will be parsed as Handlebars.</p>') }
      end
    end

    describe 'format symbols' do
  
      let(:data) { 
        { 
          name1: :activity, 
          name2: :achievement_badge, 
          name3: 'Hello World', 
          name4: 'the quick brown fox',
          name5: 'SPACE   MAN',
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

      # name1: :activity, 
      # name2: :achievement_badge, 
      # name3: 'Hello World', 
      # name4: 'the quick brown fox',
      # name5: 'space   man',
      # name6: '  spaced out   '

      context 'slash' do
        let(:template) { '{{slash name1}} {{forward_slash name2}} {{slash_forward name3}} {{slash name4}} {{slash name5}} {{slash name6}}' }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('achievement/badge') }
        it { expect(subject).to include('Hello/World') }
        it { expect(subject).to include('the/quick/brown/fox') }
        it { expect(subject).to include('SPACE/MAN') }
        it { expect(subject).to include('spaced/out') }
      end
  
      context 'back_slash' do
        let(:template) { '{{back_slash name1}} {{slash_back name2}} {{backward_slash name3}} {{back_slash name4}} {{back_slash name5}} {{back_slash name6}}' }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('achievement\badge') }
        it { expect(subject).to include('Hello\World') }
        it { expect(subject).to include('the\quick\brown\fox') }
        it { expect(subject).to include('SPACE\MAN') }
        it { expect(subject).to include('spaced\out') }
      end

      context 'double_colon' do
        let(:template) { '{{double_colon name1}} {{double_colon name2}} {{namespace name3}} {{double_colon name4}} {{double_colon name5}} {{double_colon name6}}' }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('achievement::badge') }
        it { expect(subject).to include('Hello::World') }
        it { expect(subject).to include('the::quick::brown::fox') }
        it { expect(subject).to include('SPACE::MAN') }
        it { expect(subject).to include('spaced::out') }
      end
  
      context 'humanize, then pluralize' do
        # See format below for multi-formats
        let(:template) { '{{pluralize (humanize name1)}} {{pluralize (humanize name2)}} {{pluralize (humanize name3)}} {{pluralize (humanize name4)}} {{pluralize (humanize name5)}} {{pluralize (humanize name6)}}' }
  
        it { expect(subject).to include('Activities') }
        it { expect(subject).to include('Achievement badges') }
        it { expect(subject).to include('Hello worlds') }
        it { expect(subject).to include('The quick brown foxes') }
        it { expect(subject).to include('Space men') }
        it { expect(subject).to include('Spaced outs') }
      end
    end

    describe 'multi format' do
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
  
      context 'combinations' do
        # REFACTOR: THIS NEEDS A LOT OF WORK THAT MAY NEED ME to refactor the internals
        # let(:template) { '{{snake name1}} {{snake name2}} {{snake name3}} {{snake name4}} {{snake name5}} {{snake name6}}' }
        let(:template) do <<~TEMPLATE
          {{format_as name2 'titleize,slash_forward'}}
          {{format_as name2 'humanize,slash_forward'}}
          {{format_as name2 'titleize,back_slash'}}
          {{format_as name2 'humanize,slash_backward'}}
          {{format_as name2 'constant,namespace'}}
          {{format_as name2 'titleize,double_colon'}}
          {{format_as name2 'humanize,double_colon'}}
          TEMPLATE
        end
  
        it { expect(subject).to include('Achievement/Badge') }
        it { expect(subject).to include('Achievement/badge') }
        it { expect(subject).to include('Achievement\Badge') }
        it { expect(subject).to include('Achievement\badge') }
        it { expect(subject).to include('ACHIEVEMENT::BADGE') }
        it { expect(subject).to include('Achievement::Badge') }
        it { expect(subject).to include('Achievement::badge') }
      end
    end

    describe 'common helpers' do
  
      let(:data) { {} }
  
      context 'default' do
        let(:data) { { name1: :activity } }
        let(:template) { "{{default name1 'override name1'}} {{default unknown 'override unknown'}} {{default unknown '<pre>unknown as html</pre>'}}" }
  
        it { expect(subject).to include('activity') }
        it { expect(subject).to include('override unknown') }
        it { expect(subject).to include('<pre>unknown as html</pre>') }
      end

      context 'repeat' do
        let(:template) do
          <<~TEXT
          [{{repeat 10 ' ' }}]
          [{{repeat 5 '-+'}}]
          TEXT
        end

        it do
          puts subject
        end
        it { is_expected.to include('[          ]') }
        it { is_expected.to include('[-+-+-+-+-+]') }
      end

      context 'padr' do
        let(:data) { { field1: 'First Name', field2: 'Second Name' } }
        let(:template) do
          <<~TEXT
          {{padr field1 20}}: David
          {{padr field2 20}}: Programer
          {{padr 'Age' 20}}: 20
          TEXT
        end

        it do
          expect(subject).to eq <<~TEXT
            First Name          : David
            Second Name         : Programer
            Age                 : 20
          TEXT
        end
      end

      context 'padl' do
        let(:data) { { field1: 'First Name', field2: 'Second Name' } }
        let(:template) do
          <<~TEXT
          |{{padl field1 20}}: David
          |{{padl field2 20}}: Programer
          |{{padl 'Age' 20}}: 20
          TEXT
        end

        it do
          expect(subject).to eq <<~TEXT
            |          First Name: David
            |         Second Name: Programer
            |                 Age: 20
          TEXT
        end
      end

      context 'surround' do
        let(:data) { { value: 'hello world' } }
        let(:template) do
          <<~TEXT
          {{surround_if_value value '(' ')'}}]
          TEXT
        end

        it { expect(subject).to include('(hello world)') }

        context 'with format' do
          let(:data) { { value: 'the quick brown fox' } }
          let(:template) do
            <<~TEXT
            {{surround_if_value value '(' ')'}}
            {{surround_if_value value '(' ')' 'snake' }}
            {{surround_if_value value '(' ')' 'dashify' }}
            {{surround_if_value value '(' ')' 'camel' }}
            {{surround_if_value value '(' ')' 'lamel' }}
            {{surround_if_value value '(' ')' 'titleize' }}
            {{surround_if_value value '(' ')' 'humanize' }}
            {{surround_if_value value '(' ')' 'constantize' }}
            {{surround_if_value value '(' ')' 'pluralize' }}
            TEXT
          end
  
          it { expect(subject).to include('(the quick brown fox)') }
          it { expect(subject).to include('(the_quick_brown_fox)') }
          it { expect(subject).to include('(the-quick-brown-fox)') }
          it { expect(subject).to include('(TheQuickBrownFox)') }
          it { expect(subject).to include('(theQuickBrownFox)') }
          it { expect(subject).to include('(The Quick Brown Fox)') }
          it { expect(subject).to include('(The quick brown fox)') }
          it { expect(subject).to include('(THE_QUICK_BROWN_FOX)') }
          it { expect(subject).to include('(the quick brown foxes)') }
        end
      end

      context 'prepend / prefix' do
        let(:data) { { value: :some_folder, empty_value: nil } }
        let(:template) do
          <<~TEXT
          prepend_with_valid_folder [{{prepend_if_value value '/'}}]
          prefix_with_valid_folder  [{{prefix_if_value value '/'}}]
          prepend_with_empty_folder [{{prepend_if_value empty_value '/'}}]
          prefix_with_empty_folder  [{{prefix_if_value empty_value '/'}}]
          TEXT
        end

        it { expect(subject).to include('prepend_with_valid_folder [/some_folder]') }
        it { expect(subject).to include('prefix_with_valid_folder  [/some_folder]') }
        it { expect(subject).to include('prepend_with_empty_folder []') }
        it { expect(subject).to include('prefix_with_empty_folder  []') }

        context 'with format' do
          let(:data) { { value: 'the quick brown fox' } }
          let(:template) do
            <<~TEXT
            {{prepend_if_value value '[' }}
            {{prepend_if_value value '[' 'snake' }}
            {{prepend_if_value value '[' 'dashify' }}
            {{prepend_if_value value '[' 'camel' }}
            {{prepend_if_value value '[' 'lamel' }}
            {{prepend_if_value value '[' 'titleize' }}
            {{prepend_if_value value '[' 'humanize' }}
            {{prepend_if_value value '[' 'constantize' }}
            {{prepend_if_value value '[' 'pluralize' }}
            TEXT
          end
  
          it { expect(subject).to include('[the quick brown fox') }
          it { expect(subject).to include('[the_quick_brown_fox') }
          it { expect(subject).to include('[the-quick-brown-fox') }
          it { expect(subject).to include('[TheQuickBrownFox') }
          it { expect(subject).to include('[theQuickBrownFox') }
          it { expect(subject).to include('[The Quick Brown Fox') }
          it { expect(subject).to include('[The quick brown fox') }
          it { expect(subject).to include('[THE_QUICK_BROWN_FOX') }
          it { expect(subject).to include('[the quick brown foxes') }
        end
      end

      context 'append / suffix' do
        let(:data) { { value: :some_folder, empty_value: nil } }
        let(:template) do
          <<~TEXT
          append_with_valid_folder [{{append_if_value value '/'}}]
          suffix_with_valid_folder [{{suffix_if_value value '/'}}]
          append_with_empty_folder [{{append_if_value empty_value '/'}}]
          suffix_with_empty_folder [{{suffix_if_value empty_value '/'}}]
          TEXT
        end

        it { expect(subject).to include('append_with_valid_folder [some_folder/]') }
        it { expect(subject).to include('suffix_with_valid_folder [some_folder/]') }
        it { expect(subject).to include('append_with_empty_folder []') }
        it { expect(subject).to include('suffix_with_empty_folder []') }

        context 'with format' do
          let(:data) { { value: 'the quick brown fox' } }
          let(:template) do
            <<~TEXT
            {{append_if_value value ']' }}
            {{suffix_if_value value ']' 'snake' }}
            {{append_if_value value ']' 'dashify' }}
            {{suffix_if_value value ']' 'camel' }}
            {{append_if_value value ']' 'lamel' }}
            {{suffix_if_value value ']' 'titleize' }}
            {{append_if_value value ']' 'humanize' }}
            {{suffix_if_value value ']' 'constantize' }}
            {{append_if_value value ']' 'pluralize' }}
            TEXT
          end
  
          it { expect(subject).to include('the quick brown fox]') }
          it { expect(subject).to include('the_quick_brown_fox]') }
          it { expect(subject).to include('the-quick-brown-fox]') }
          it { expect(subject).to include('TheQuickBrownFox]') }
          it { expect(subject).to include('theQuickBrownFox]') }
          it { expect(subject).to include('The Quick Brown Fox]') }
          it { expect(subject).to include('The quick brown fox]') }
          it { expect(subject).to include('THE_QUICK_BROWN_FOX]') }
          it { expect(subject).to include('the quick brown foxes]') }
        end
      end
      
      context 'json' do
        let(:template) { "{{json this}}" }
        let(:data) { { name: :activity, rows: [{ key: 1, value: '11'}, { key: 2, value: '22', x: true, y: false}] } }

        context 'when root is array' do
          it { is_expected.to start_with('{"name":"activity","rows":[{"key":1,"value":"11"},{"key":2,"value":"22","x":true,"y":false}]}') }
        end

        context 'when root is hash' do
          let(:data) { [{ key: 1, value: '11'}, { key: 2, value: '22', x: true, y: false}] }
          it { is_expected.to start_with('[{"key":1,"value":"11"},{"key":2,"value":"22","x":true,"y":false}]') }
        end
        
        # it { expect(subject).to include('activity') }
        # it { expect(subject).to include('override unknown') }
        # it { expect(subject).to include('<pre>unknown as html</pre>') }
      end

      context 'hash' do
        let(:template) { "{{hash}} - {{hash 1}} - {{hash 4}}" }
  
        it { expect(subject).to include('# - # - ####') }
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
      
        context 'when case-sensitive equal' do
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
  