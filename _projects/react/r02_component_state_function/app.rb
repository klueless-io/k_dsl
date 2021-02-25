# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :r02_component_state_function do
  settings do
    name                          parent.key
    app_type                      :react
    title                         'R02 Component State Function'
    description                   'R02 Component State Function '
    application                   'r02-component-state-function'
    git_repo_name                 'r02-component-state-function'
    git_organization              'klueless-react-samples'
    avatar                        'UX Designer'
    main_story                    'As a Front End Developer, I quickly understand components, state and functions, so that I can build complex react applications'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/react/samples/r02-component-state-function'
    application_lib_path          'r02-component-state-function'
    namespace_root                'r02-component-state-function'
    template_rel_path             'react'
    app_path                      '~/dev/react/r02-component-state-function'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-react-samples'
    github_new_repo s.git_repo_name, organization: 'klueless-react-samples'

    # run_command "npx create-react-app ."

    # run_command 'code .' # run_command will ensure the folder exists

    new_blueprint :bootstrap       , definition_subfolder: 'react', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
