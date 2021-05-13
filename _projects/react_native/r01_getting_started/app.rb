# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :r01_getting_started do
  settings do
    name                          parent.key
    app_type                      :react_native
    title                         'R01 Getting Started'
    description                   'R01 Getting Started '
    application                   'r01_getting_started'
    git_repo_name                 'r01_getting_started'
    git_organization              'klueless-react-native-samples'
    avatar                        'UX Designer'
    main_story                    'As a Developer, I want to create my first React Native App, so that I can do mobile programming'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/react-native/samples/r01-getting-started'
    application_lib_path          'r01_getting_started'
    namespace_root                'r01_getting_started'
    template_rel_path             'react-native'
    app_path                      '~/dev/react_native/r01_getting_started'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-react-native-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-react-native-samples'

    # run_command "npx expo init ."
    # run_command "npx expo start"

    # run_command 'code .' # run_command will ensure the folder exists

    new_blueprint :bootstrap       , definition_subfolder: 'react-native', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
