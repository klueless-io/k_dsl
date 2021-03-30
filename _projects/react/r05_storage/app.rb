# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :r05_storage do
  settings do
    name                          parent.key
    app_type                      :react
    title                         'R05 Storage'
    description                   'R05 Storage '
    application                   'r05-storage'
    git_repo_name                 'r05-storage'
    git_organization              'klueless-react-samples'
    avatar                        'UX Designer'
    main_story                    'As a React Developer, I want to keep state between pages, so that my app is responsive with live data'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/react/samples/r05-storage'
    application_lib_path          'r05-storage'
    namespace_root                'r05-storage'
    template_rel_path             'react'
    app_path                      '~/dev/react/r05-storage'
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
