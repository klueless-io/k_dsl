# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :r04_react_router do
  settings do
    name                          parent.key
    app_type                      :react
    title                         'R04 React Router'
    description                   'R04 React Router '
    application                   'r04-react-router'
    git_repo_name                 'r04-react-router'
    git_organization              'klueless-react-samples'
    avatar                        'React Developer'
    main_story                    'As a React Developer, I want to navigate to pages using urls, so that I can deep link page navigation'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/react/samples/r04-react-router'
    application_lib_path          'r04-react-router'
    namespace_root                'r04-react-router'
    template_rel_path             'react'
    app_path                      '~/dev/react/r04-react-router'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-react-samples'
    github_new_repo s.git_repo_name, organization: 'klueless-react-samples'

    run_command "npx create-react-app ."

    run_command 'code .' # run_command will ensure the folder exists

    new_blueprint :bootstrap       , definition_subfolder: 'react', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
