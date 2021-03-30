# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :r06_monopoly do
  settings do
    name                          parent.key
    app_type                      :react
    title                         'R06 Monopoly'
    description                   'R06 Monopoly '
    application                   'r06-monopoly'
    git_repo_name                 'r06-monopoly'
    git_organization              'klueless-react-samples'
    avatar                        'UX Designer'
    main_story                    'As a Monopoly Player, I want a beautiful UX to play monopoly on, so that I am an engaged player'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/react/samples/r06-monopoly'
    application_lib_path          'r06-monopoly'
    namespace_root                'r06-monopoly'
    template_rel_path             'react'
    app_path                      '~/dev/react/r06-monopoly'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    github_del_repo s.git_repo_name, organization: 'klueless-react-samples'
    github_new_repo s.git_repo_name, organization: 'klueless-react-samples'

    run_command "npx create-react-app ."

    run_command 'code .' # run_command will ensure the folder exists

    new_blueprint :bootstrap       , definition_subfolder: 'react', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
