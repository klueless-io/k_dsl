KDsl.blueprint :{{snake name}} do
  microapp     = import(:{{settings.name}}, :microapp)

  is_run = 1

  settings do
    name                parent.key
    type                parent.type
    template_rel_path   'ruby-cmdlet'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')] # 'open,open_template'

    # ADD EXE (executable)
    row 'exe/cmdlet_name'                 , 'exe/{{settings.application}}'

    # ADD EXT (extensions)
    row 'ext/cmdlet_name/cmdlet_name.c'   , 'ext/{{settings.application}}/{{settings.application}}.c'
    row 'ext/cmdlet_name/cmdlet_name.h'   , 'ext/{{settings.application}}/{{settings.application}}.h'
    row 'ext/cmdlet_name/extconf.rb'      , 'ext/{{settings.application}}/extconf.rb'

    # Setup CLI and command execution
    row 'lib/cmdlet_name.rb'              , 'lib/{{settings.application}}.rb'
    row 'lib/cmdlet_name/version.rb'      , 'lib/{{settings.application}}/version.rb', conflict: 'skip'
    row 'lib/cmdlet_name/cli.rb'          , 'lib/{{settings.application}}/cli.rb'
    row 'lib/cmdlet_name/app.rb'          , 'lib/{{settings.application}}/app.rb'
    row 'lib/cmdlet_name/command.rb'      , 'lib/{{settings.application}}/command.rb'

    row '.keep'                           , 'lib/{{settings.application}}/commands/.keep'
    row '.keep'                           , 'lib/{{settings.application}}/templates/.keep'

    row 'spec/spec_helper.rb'
    row 'spec/cmdlet_name_spec.rb'        , 'spec/{{settings.application}}_spec.rb'
    
    row '.rspec'
    row '.travis.yml'                     , command: 'delete', note: 'this was generated by bundle gem'
    row 'CODE_OF_CONDUCT.md'
    row 'Gemfile'
    row 'LICENSE.txt'
    row 'cmdlet_name.gemspec'             , '{{settings.application}}.gemspec'
    row 'Rakefile'
    row 'README.md'
    row 'Guardfile'
    row '.rubocop.yml'
  end

  # instructions :custom do
  #   fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'compare'), f(:after_write, 'open')]

  #   # row 'README.md'#, conflict: 'overwrite'
  #   # row '.rubocop.yml'
  # end

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
  def on_action
    run_blueprint microapp: microapp
    run_command 'rubocop --auto-gen-config'
    hf 'Bootstrap the Ruby Gem so it can be used as a Ruby Cmdlet'
  end if is_run == 1
end
