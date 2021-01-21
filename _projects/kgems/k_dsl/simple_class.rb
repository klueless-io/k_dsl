# def template_option_properties(dsl)
#   data = template_option_data(dsl)
#   template = template_option_template

#   output = KDsl::TemplateRendering::TemplateHelper.process_template(template, data)
# end

# def template_option_data(dsl)
#   data = dsl.raw_data_struct

#   data.active_props = OpenStruct.new(rows: data.props.rows.select { |p| p.active == 1 })

#   grouped_rows = data.active_props
#                      .rows
#                      .group_by { |x| x.group }
#                      .map { |g,rows| { group: g, props: rows.map { |r| r.to_h } } }
  
#   data.grouped_rows = OpenStruct.new(rows: KDsl::Util.data.to_struct(grouped_rows))

#   L.o data
#   data
# end

# def template_option_template
#   template = <<~RUBY
#     {{#each grouped_rows.rows}}
#     # {{titleize this.group}}
    
#     {{#each this.props}}
#     attr_accessor :{{this.field}}
#     {{/each}}
#     {{/each}}
#   RUBY
# end

KDsl.blueprint :code_spec_pair do
  microapp          = import(:k_dsl, :microapp)
  template_options  = import(:template_options)

  s = settings do
    name                'github_linkable'
    template_rel_path   'ruby-cmdlet'
    template_base_name  'extension'
    output_rel_path     'extensions'

    name                'template_renderer'
    name                'template_options'
    template_base_name  'code'
    output_rel_path     'template_rendering'

    name                'parameter_info'
    output_rel_path     'peaky'

    # xx template_options.fuckit
    # attributes          template_options.attributes.rows.select { |r| r.active == 1 }.map { |r| r.to_h }
    # attributes_active   template_options.attributes_active.map { |r| r.to_h }
    # output              template_options.settings.output
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row "#{s.template_base_name}.rb"      , "lib/k_dsl/#{s.output_rel_path}/#{s.name}.rb"
    row "#{s.template_base_name}_spec.rb" , "spec/k_dsl/#{s.output_rel_path}/#{s.name}_spec.rb"
   end

  # table :props do
  #   fields [:active, :group, :field, :dsl_field, :output_field, :description]

  #   # DSL's are usually a 1 to 1 generation
  #   # Output's are both 1 to 1 and 1 to many generations

  #   # Input (.definition or .template)
  #   # If you are building a new project DSL, then input is .definition
  #   # If you are building a new project artifact (text/code), then ,input is .template
  #   row 1, :input, :input_subfolder         , :definition_subfolder         , :template_rel_path
  #   row 1, :input, :input_name              , :definition_name              , :template_name
  #   row 1, :input, :input_search_folders    , :X_definition_search_folders  , [:app_template_path, :common_template_path]
  #   row 1, :input, :input_folder            , :definition_folder            , '???'
  #   row 1, :input, :input_file              , :definition_file              , 'template.file'

  #   # Output (.dsl or .output)
  #   # If you are building a new project DSL, then output is _project/{project_name}/{some_file}
  #   # If you are building a new project artifact (text/code), then output folder is the project repo
  #   row 1, :output, :output_subfolder        , :output_subfolder             , 'opt.microapp.settings.app_path'
  #   row 1, :output, :output_filename         , :output_filename              , :output
  #   row 1, :output, :output_folder           , :output_folder                , '???'
  #   row 1, :output, :output_file             , :output_file                  , :output_file

  #   # Meta (open editors, file compares, debug logging)
  #   row 0, :meta, :show_editor                  , :show_editor                  , :na             , 'open file in editor'
  #   row 0, :meta, :debug_only                   , :debug_only                   , :na             , 'show debug output, but do not execute/generate'

  #   # Template Extras (these wer in template render, but not definition render)
  #   row 1, :meta, :iif                          , :na                           , :iif            , 'evaluate conditional, only run on true'
  #   row 1, :meta, :action                       , :na                           , :command        , 'command/action to take [generate, delete, mkdir, execute, fork]'
  #   row 1, :meta, :action_debug                 , :na                           , :na             , 'debug action parameters [none, detail]'
  #   row 1, :meta, :on_action_debug              , :na                           , :na             , 'debug action parameters [continue, abort]'
  #   row 1, :meta, :on_write_conflict            , :na                           , :conflict       , 'action when output file exists [skip, compare, overwrite]'
  #   row 1, :meta, :on_written                   , :na                           , :after_write    , 'action after output file is written [open, open_if_update, open_if_new, open_template]'
  # end

  def on_action
    # new_blueprint 'template_options', microapp: microapp, definition_name: 'entity', definition_subfolder: 'ruby-gem', output_subfolder: :entities, f: true, show_editor: false
    
    # self.raw_data['instructions']['rows'][0]['properties'] = '# template_options.settings.template '

    run_blueprint
    # of = "lib/k_dsl/#{s.output_rel_path}/#{s.name}.rb"
    # L.error of
    # write_as(data, of, is_edit: true, template: template, output_file: of)
    # write_json is_edit: true
  end
end
