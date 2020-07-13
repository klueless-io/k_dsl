# K Dsl

> KDSL &#x27;k_dsl&#x27; is ruby gem for name/value and tabular data DSL generation

KDSL is a DSL builder that uses natural language constructs and applies an MVC pattern to produce SloCode

KDSL follows the MVC pattern for producing code.

The model folder contains DSLS for producing documents with multiple setting groups and tables
The view folder uses Handlebars to merge with the models to produce various code assets

- KDsl -> for the controller actions and memory management
- This is the aggregate root gem

When using the source code for this gem, start by running `bin/setup` to install locally or `bundle install`

To experiment with that code, run `bin/console` for an interactive prompt or run `exe/k_dsl` to see a list of commands.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'k_dsl'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install k_dsl
```

## Stories

As a Developer, I should be able to implement a flexible DSL quickly, so that I build my own Domain Language


## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/k_dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the KDsl project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/k_dsl/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) David. See [MIT License](LICENSE.txt) for further details.
