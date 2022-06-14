KDsl.blueprint :bootstrap_upgrade do
  settings do
    name                parent.key
    type                parent.type
    template_rel_path   'ruby-gem'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, '')]

    # Setup CLI and command execution
    row 'lib/applet_name.rb'              , 'lib/k_builder/package_json.rb'          , after_write: 'prettier'
    row 'lib/applet_name/version.rb'      , 'lib/k_builder/package_json/version.rb'  , after_write: 'prettier'

    row 'spec/spec_helper.rb'
    row 'spec/applet_name_spec.rb'        , 'spec/k_builder/package_json_spec.rb'
    
    row '.rspec'
    row '.rubocop.yml'
    row '.travis.yml'                     , command: 'delete', note: 'this was generated by bundle gem'
    row 'applet_name.gemspec'             , 'k_builder-package_json.gemspec'
    row 'CODE_OF_CONDUCT.md'
    row 'Gemfile'
    row 'Guardfile'
    row 'LICENSE.txt'
    row 'Rakefile'
    row 'README.md'
  end

  is_run = 0

  def on_action
    run_blueprint microapp: import(:k_builder_package_json, :microapp)

    # THESE do not work from Klue, need to run bundle install, rspec (or guard) and cop from command line first
    # run_command 'bin/setup'
    # run_command 'bundle install'
    # run_command 'rspec'
    # run_command 'cop'

    # Can run after bundle install
    # run_command 'rubocop --auto-gen-config'
    # hotfix 'Upgrade default readme and ruby files, plus add support for, rubocop, guard to k_builder-package_json'
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end