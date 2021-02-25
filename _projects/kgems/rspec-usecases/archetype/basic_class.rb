KDsl.blueprint :basic_class do
  microapp     = import(:rspec_usecases, :microapp)

  s = settings do
    name                :content
    output_rel_path     'contents'
    template_rel_path   'ruby-cmdlet'
    template_base_name  'basic_code'
  end

  out_path = s.output_rel_path.present? ? "/#{s.output_rel_path}" : ''

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'skip'), f(:after_write, 'open')]

    row "#{s.template_base_name}.rb"      , "lib/rspec/usecases#{out_path}/#{s.name}.rb", after_write: 'prettier,open'
    row "#{s.template_base_name}_spec.rb" , "spec/rspec/usecases#{out_path}/#{s.name}_spec.rb"
  end

  table :attributes do
    fields [:name, :description]

    # row :summary
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

    run_blueprint microapp: import(:rspec_usecases, :microapp),
                  model_attributes: model_attributes,
                  model_debug: model_debug,
                  spec_attributed: spec_attributes

    # write_json is_edit: true
  end
end
