KDsl.blueprint :method_call_minimum_params_render do
  microapp     = import(:peeky, :microapp)

  s = settings do
    name                :method_call_minimum_params_render
    output_rel_path     'renderer'
    template_rel_path   'ruby-cmdlet'
    template_base_name  'basic_code'
  end

  out_path = s.output_rel_path.present? ? "/#{s.output_rel_path}" : ''

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row "#{s.template_base_name}.rb"      , "lib/peeky#{out_path}/#{s.name}.rb"
    row "#{s.template_base_name}_spec.rb" , "spec/peeky#{out_path}/#{s.name}_spec.rb"
  end

  table :attributes do
    fields [:name, :description]

    # row :name
  end

  def on_action
    model_attributes = write_to_s template: <<~TEXT
    {{#each attributes.rows}}

          # {{description}}
          attr_accessor :{{snake name}}
    {{/each}}
    TEXT

    model_debug = write_to_s template: <<~TEXT
    
    def debug
                {{#each attributes.rows}}
                puts "{{padr name}}: {{hash}}{{curly_open}}{{name}}{{curly_close}}"
                {{/each}}
              end
    TEXT

    spec_attributes = write_to_s template: <<~TEXT
    
    {{#each attributes.rows}}
    describe '.{{name}}' do
      subject { instance.{{name}} }
      fit { puts subject; }
    end
    {{/each}}
    TEXT
    # write_clipboard template: xxx

    # run_blueprint microapp: import(:peeky, :microapp),
    #               model_attributes: model_attributes,
    #               model_debug: model_debug,
    #               spec_attributed: spec_attributes

    # write_json is_edit: true
  end
end
