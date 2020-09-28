# frozen_string_literal: true

guard :bundler, cmd: 'bundle install' do
  watch('Gemfile')
  watch('k_dsl.gemspec')
end

guard :rspec, cmd: 'bundle exec rspec -f doc' do
  require 'guard/rspec/dsl'
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)
  watch(%r{^lib/k_dsl/(.+)\.rb$}) { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^lib/k_dsl/commands/(.+)\.rb$}) { |m| "spec/unit/commands/#{m[1]}_spec.rb" }
end

# Alterations to run rake can re-executed
guard :rake, :task => 'k_dsl:run', :run_on_start => false, run_on_all: false do
  # Alterations to the RAKE task should reload
  watch(%r{^lib/tasks/run.rake$}) {
    ::Rake::Task.clear
    # ::Rake.application.init
    ::Rake.application.load_rakefile
    system('rake k_dsl:run')
    # 'lib/tasks/run.rake'
  }
end

# Listen.to('/Users/davidcruwys/dev/kgems/k_dsl/lib/tasks/run.rake') do |modified, added, removed|
#   puts 'xxxxxxx'

#   system('rake k_dsl:run')
#   # files = modified + added
#   # begin
#   #   files.each do |file| 
#   #     load file
#   #   end

#   # rescue => exception
#   #   puts exception.message      
#   # end
# end.start

