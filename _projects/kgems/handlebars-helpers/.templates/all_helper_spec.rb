# frozen_string_literal: true

require 'handlebars/helpers/template'

RSpec.describe 'Handlebars::Helpers::AllHelper' do
  subject { Handlebars::Helpers::Template.render(template, data) }

  {{#each helper_groups}}
  context '{{./description}}' do
    {{#each helpers}}
    {{#if test_in}}
    {{> simple_test_partial }}
    {{else}}
    {{#if tests}}
    {{> multi_parameter_tests_partial }}
    {{/if}}
    {{/if}}

    {{/each}}
  end

  {{/each}}
end

{{#*inline "simple_test_partial"}}
describe '{{safe ./description}}' do
  let(:data) { '{{test_in}}' }
  let(:expected) { '{{test_out}}' }
  {{#each aliases}}
  context '{{.}}' do
    let(:template) { '{{curly_open 2}}{{.}} .{{curly_close 2}}' }

    it { is_expected.to eq(expected) }
  end

  {{/each}}
end
{{/inline}}
{{#*inline "multi_parameter_tests_partial"}}
describe '{{safe ./description}}' do
  {{#each tests}}
  {{#if @first}}
  let(:expected) { '{{safe expected_value}}' }
  let(:data) { { {{#each params}}{{name}}: {{#if hash_value}}{{safe hash_value}}{{/if}}{{#if string_value}}'{{safe string_value}}'{{/if}}{{#if nil_value}}nil{{/if}}{{#if @last}}{{else}}, {{/if}}{{/each}} } }
  {{/if}}

  context '{{alias}}' do
    let(:template) { '{{~#if template~}}{{safe template}}{{^}}{{curly_open 2}}{{alias}} {{#each params}}{{name}}{{#if @last}}{{else}} {{/if}}{{/each}}{{curly_close 2}}{{~/if~}}' }

    {{#if custom_expectation}}
    {{safe custom_expectation}}
    {{^}}
    it { is_expected.to eq(expected) }
    {{/if}}
  end

  {{/each}}

end
{{/inline}}
