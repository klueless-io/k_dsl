# {{titleize settings.application}}

> {{settings.description}}

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/{{snake settings.application}}`.

When using the source code for this gem, start by running `bin/setup` to install locally or `bundle install`

To experiment with that code, run `bin/console` for an interactive prompt or run `exe/{{snake settings.application}}` to see a list of commands.

## Installation

Add this line to your application's Gemfile:

```ruby
gem '{{snake settings.application}}'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install {{snake settings.application}}
```

## Stories

{{#each stories}}

{{this.story}}

{{#each this.tasks}}- {{this}}
{{/each}}

{{/each}}

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/{{snake settings.application}}. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the {{camelU settings.application}} project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/{{snake settings.application}}/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) {{settings.author}}. See [MIT License](LICENSE.txt) for further details.
