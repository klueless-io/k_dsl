KDsl.blueprint :code_spec_pair do
  microapp     = import(:k_dsl, :microapp)

  s = settings do
    name                'github_linkable'
    template_rel_path   'ruby-cmdlet'
    output_base_name    'extension'
    output_rel_path     'extensions'

    # name                'github_linkable'
    # output_base_name    'extension'
    # output_rel_path     'template_rendering'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row "#{s.output_base_name}.rb"      , "lib/k_dsl/#{s.output_rel_path}/#{s.name}.rb"
    row "#{s.output_base_name}_spec.rb" , "spec/#{s.output_rel_path}/#{s.name}_spec.rb"
  end

  table :pairs do
    fields [:field, :dsl_field, :output_field, :description]

    # DSL's are usually a 1 to 1 generation
    # Output's are both 1 to 1 and 1 to many generations

    row 'output_subfolder'

    # Input (.definition or .template)
    # If you are building a new project DSL, then input is .definition
    # If you are building a new project artifact (text/code), then ,input is .template
    row :definition_subfolder         , :template_rel_path
    row :definition_name              , :template_name
    row :X_definition_search_folders  , [:app_template_path, :common_template_path]
    row :definition_folder            , '???'
    row :definition_file              , 'template.file'

    # Output (.dsl or .output)
    # If you are building a new project DSL, then output is _project/{project_name}/{some_file}
    # If you are building a new project artifact (text/code), then output folder is the project repo
    row :output_subfolder             , 'opt.microapp.settings.app_path'
    row :output_filename              , :output
    row :output_folder                , '???'
    row :output_file                  , :output_file

    # Meta (open editors, file compares, debug logging)
    row :show_editor                  , :na             , 'open file in editor'
    row :debug_only                   , :na             , 'show debug output, but do not execute/generate'

    # Template Extras (these wer in template render, but not definition render)
    row :na                           , :iif            , 'evaluate conditional, only run on true'
    row :na                           , :command        , 'command/action to take [generate, delete, mkdir, execute, fork]'
    row :na                           , :conflict       , 'action when output file exists [skip, compare, overwrite]'
    row :na                           , :after_write    , 'action after output file is written [open, open_if_overwritten, open_if_new, open_template, ]'
  end

  actions do
    # run_blueprint
    # write_json is_edit: true
  end
end
