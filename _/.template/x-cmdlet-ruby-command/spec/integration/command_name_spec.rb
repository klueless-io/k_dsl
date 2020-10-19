# frozen_string_literal: true

RSpec.describe '`{{snake settings.application}} {{snake command.name}}` command', type: :cli do
  it 'executes `{{snake settings.application}} help {{snake command.name}}` command successfully' do
    output = `{{snake settings.application}} help {{snake command.name}}`

=begin
Usage:
  {{snake settings.application}} {{snake command.name}} {{> argList}}

Options:
  -h, [--help], [--no-help]  # Display usage information

{{command.description}}
=end

    expect(output).to include('{{snake settings.application}} {{snake command.name}} ')
    expect(output).to include('--help')
  end
end
{{#*inline "argList"}}
{{#each args}}{{constantize this.name}}{{#if @last}}{{else}}, {{/if}}{{/each}}{{/inline}}
