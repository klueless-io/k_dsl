# frozen_string_literal: true

require_relative 'lib/{{snake settings.application}}/version'

Gem::Specification.new do |spec|
  spec.name          = '{{snake settings.application}}'
  spec.version       = {{camelU settings.application}}::VERSION
  spec.authors       = ['{{settings.author}}']
  spec.email         = ['{{settings.author_email}}']

  spec.summary       = '{{settings.description}}'
  spec.description   = '{{settings.description}}'
  spec.homepage      = '{{settings.website}}'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/{{settings.github_user}}/{{snake settings.application}}'
  spec.metadata['changelog_uri'] = 'https://github.com/{{settings.github_user}}/{{snake settings.application}}/commits/master'

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
  spec.extensions    = ['ext/{{snake settings.application}}/extconf.rb']

  # spec.add_dependency 'tty-box',         '~> 0.5.0'
end
