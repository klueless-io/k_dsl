# {{titleize microapp.settings.application}}

> {{safe microapp.settings.description}}

{{main_story}}

## Usage

{{#each usage.detailed}}
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
