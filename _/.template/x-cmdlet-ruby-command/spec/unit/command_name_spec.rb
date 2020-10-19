# frozen_string_literal: true

require '{{snake settings.application}}/commands/{{command.name}}'

RSpec.describe {{camelU settings.application}}::Commands::{{camelU command.name}} do
  {{> argLetInitilize}}
  let(:options) { {} }

  subject { {{camelU settings.application}}::Commands::{{camelU command.name}}.new({{> argList}}options) }

  describe 'initialize' do
    it 'executes `{{command.name}}` command successfully' do
      output = StringIO.new
      subject.execute(output: output)

      expect(output.string).to eq('')
    end
  end
end
{{#*inline "argList"}}
{{#each args}}{{this.name}}, {{/each}}{{/inline}}
{{#*inline "argLetInitilize"}}
{{#each args}}let(:{{this.name}}) { nil }
{{/each}}{{/inline}}
