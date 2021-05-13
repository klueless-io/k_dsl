# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :r02_navigation do
  settings do
    name                          parent.key
    app_type                      :react_native
    title                         'R02 Navigation'
    description                   'R02 Navigation '
    application                   'r02_navigation'
    git_repo_name                 'r02_navigation'
    git_organization              'klueless-react-native-samples'
    avatar                        'UX Designer'
    main_story                    'As a Developer, I want to create my first React Native App, so that I can do mobile programming'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/react-native/samples/r02-navigation'
    application_lib_path          'r02_navigation'
    namespace_root                'r02_navigation'
    template_rel_path             'react-native'
    app_path                      '~/dev/react_native/r02-navigation'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-react-native-samples'
    github_new_repo s.git_repo_name, organization: 'klueless-react-native-samples'

    # run_command "npx expo init ."

    run_command 'code .' # run_command will ensure the folder exists

    new_blueprint :bootstrap       , definition_subfolder: 'react-native', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
