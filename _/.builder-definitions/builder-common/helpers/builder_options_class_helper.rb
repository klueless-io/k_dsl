log.kv 'load', 'builder_options_helper' if AppDebug.require?

module BuilderOptionsClassHelper
  def init
    BuilderOptions.new
  end

  # Example
  #   BuilderOptions.generate_options_method(builder, :create_projects, params: %i[name], flags: %i[create delete])
  def generate_options_method(builder, name, params: [], flags: [])
    builder.clipboard_copy(template: create_options_section_template, name: name, params: params, flags: flags)
    log.warn('options_method has been generated, use "paste" to see the generated code.')
  end
  
  def create_options_section_template
    <<-RUBY
  # BuilderOptions.generate_options_method(builder, :{{name}}, flags: %i[{{#each flags}}{{.}}{{#if @last}}{{^}} {{/if}}{{/each}}], params: %i[{{#each params}}{{.}}{{#if @last}}{{^}} {{/if}}{{/each}}])
  # .{{name}}(1{{#each flags}}, {{.}}: 0{{/each}}{{#each params}}, {{.}}: ''{{/each}})
  def {{name}}(active{{#each flags}}, {{.}}: 0{{/each}}{{#each params}}, {{.}}: ''{{/each}})
    active = active == true || active == 1

    {{#if flags}}
    # Flags
    {{#each flags}}
    {{.}} = active && ({{.}} == true || {{.}} == 1)
    {{/each}}
    {{/if}}

    @{{name}} = {
      active: active{{#each flags}},
      {{.}}: {{.}}{{/each}}{{#each params}},
      {{.}}: {{.}}{{/each}}
    }

    self
  end
    RUBY
  end
end
