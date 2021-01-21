# frozen_string_literal: true

require_relative 'lib/{{microapp.settings.application_lib_path}}/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version  = '>= 2.5'
  spec.name                   = '{{microapp.settings.application}}'
  spec.version                = {{microapp.settings.application_lib_namespace}}::VERSION
  spec.authors                = ['{{microapp.settings.author}}']
  spec.email                  = ['{{microapp.settings.author_email}}']

  spec.summary                = '{{microapp.settings.description}}'
  spec.description            = <<-TEXT
    {{microapp.settings.description}}
  TEXT
  spec.homepage               = '{{microapp.settings.website}}'
  spec.license                = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/{{project.config.github.user}}/{{microapp.settings.application}}'
  spec.metadata['changelog_uri'] = 'https://github.com/{{project.config.github.user}}/{{microapp.settings.application}}/commits/master'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the RubyGem files that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  # spec.extensions    = ['ext/{{snake microapp.settings.application}}/extconf.rb']

  # spec.add_dependency 'tty-box',         '~> 0.5.0'
end
