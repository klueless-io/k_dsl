# frozen_string_literal: true

require 'handlebars/helpers/{{snake blueprint.settings.category}}/{{snake blueprint.settings.name}}'

RSpec.describe Handlebars::Helpers::{{camel blueprint.settings.category}}::{{camel blueprint.settings.name}} do
  {{#if blueprint.settings.example_input_value}}
  {{> simple_let_value}}
  {{/if}}

  # {{safe blueprint.settings.description}}
  describe '#parse' do
    {{#if blueprint.settings.example_input_value}}
    {{> simple_parse}}
    {{^}}
    {{> smart_parse}}
    {{/if}}
  end

  describe 'use as handlebars helper' do
    {{#if blueprint.settings.example_input_value}}
    {{> simple_handlebars_helper}}
    {{^}}
    {{> smart_handlebars_helper}}
    {{/if}}
  end
end
{{#*inline "simple_let_value"}}
let(:value) { '{{blueprint.settings.test_input_value}}' }
{{/inline}}
{{#*inline "smart_let_value"}}
{{#each blueprint.settings.test_case.params}}
let(:{{name}}) { nil }
{{/each}}
{{/inline}}

{{#*inline "simple_parse"}}
subject { described_class.new.parse(value) }

it { is_expected.to eq('{{blueprint.settings.test_output_value}}') }

it_behaves_like 'nil will parse to empty'

it_behaves_like 'valid value will parse successfully',
                'trailing number supplied',
                'twenty five66',
                'TwentyFive66'

it_behaves_like 'valid value will parse successfully',
                'trailing space and number supplied',
                'twenty five 66',
                'TwentyFive66'
{{/inline}}
{{#*inline "smart_parse"}}
subject { described_class.new.parse({{#each blueprint.settings.test_case.params}}{{name}}{{#if @last}}{{else}}, {{/if}}{{/each}}) }

{{> smart_let_value}}

context 'safely handle nil' do
  it { is_expected.to eq('') }
end

context 'context group' do
  context 'when xxx' do
    let(:value) { 'xxx' }
    it { is_expected.to eq('yyy') }
  end
end
{{/inline}}
{{#*inline "simple_handlebars_helper"}}
let(:subject) do
  Handlebars::Helpers::Template.render(template, value) do |register|
    register.helper(:{{dashify blueprint.settings.name}}, &described_class.new.handlebars_helper)
  end
end
let(:template) { '{{curly_open 2}}{{snake blueprint.settings.name}} .{{curly_close 2}}' }

it { is_expected.to eq('{{blueprint.settings.test_output_value}}') }
{{/inline}}
{{#*inline "smart_handlebars_helper"}}
let(:subject) do
  Handlebars::Helpers::Template.render(template, data) do |register|
    register.helper(:{{snake blueprint.settings.name}}, &described_class.new.handlebars_helper)
  end
end

let(:template) { '{{curly_open 2}}{{snake blueprint.settings.name}}{{#each blueprint.settings.test_case.params}} {{name}}{{/each}}{{curly_close 2}}' }
let(:data) { { {{#each blueprint.settings.test_case.params}}{{name}}: {{name}}{{#if @last}}{{else}}, {{/if}}{{/each}} } }
{{> smart_let_value}}

context 'when nil' do
  it { is_expected.to eq('') }
end
context 'when xxx' do
  let(:value) { 'xxx' }
  it { is_expected.to eq('yyy') }
end
{{/inline}}
