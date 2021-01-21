# frozen_string_literal: true

RSpec.describe {{microapp.settings.application_lib_namespace}} do
  it 'has a version number' do
    expect({{microapp.settings.application_lib_namespace}}::VERSION).not_to be nil
  end

  it 'has a standard error' do
    expect { raise {{microapp.settings.application_lib_namespace}}::Error, 'some message'}.
      to raise_error('some message')
  end
end
