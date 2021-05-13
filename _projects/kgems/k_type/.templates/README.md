# {{titleize microapp.settings.application}}

> {{safe microapp.settings.description}}

## Installation

Add this line to your application's Gemfile:

```ruby
gem '{{microapp.settings.application}}'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install {{microapp.settings.application}}
```

## Stories

### Main Story

{{main_story}}

See all [stories](./STORIES.md)

{{#if stories.featured}}
### Featured Stories
{{/if}}
{{#each stories.featured}}
- {{this.story}}
{{/each}}

## Usage

See all [usage examples](./USAGE.md)

{{#each usage.featured}}
### {{titleize this.group}}

{{this.description}}

{{#each this.examples}}
{{#if ./name}}
#### {{./name}}
{{/if}}
{{./description}}

{{#if ./ruby}}
```ruby
{{safe ./ruby}}```
{{/if}}
{{#if ./code_block}}
{{#with ./code_block}}
```{{./format}}
{{safe ./content}}```
{{/with}}
{{/if}}

{{/each}}

{{/each}}


## Development

Checkout the repo

```bash
git clone {{project.config.github.user}}/{{microapp.settings.application}}
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 

`{{microapp.settings.application}}` is setup with Guard, run `guard`, this will watch development file changes and run tests automatically, if successful, it will then run rubocop for style quality.

To release a new version, update the version number in `version.rb`, build the gem and push the `.gem` file to [rubygems.org](https://rubygems.org).

```bash
rake publish
rake clean
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/klueless-io/{{microapp.settings.application}}. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the {{titleize microapp.settings.application}} project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/klueless-io/{{microapp.settings.application}}/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) {{microapp.settings.author}}. See [MIT License](LICENSE.txt) for further details.
