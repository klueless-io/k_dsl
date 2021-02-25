# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  settings do
    name                          parent.key
    app_type                      :react
    title                         '{{titleize name}}'
    description                   '{{titleize name}} {{settings.description_suffix}}'
    application                   '{{dashify name}}'
    git_repo_name                 '{{dashify name}}'
    git_organization              'klueless-react-samples'
    avatar                        'UX Designer'
    main_story                    '{{settings.main_story}}'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/{{settings.website_slug_group}}/{{dashify settings.website_slug}}'
    application_lib_path          '{{dashify name}}'
    namespace_root                '{{dashify name}}'
    template_rel_path             'react'
    app_path                      '~/dev/{{settings.project_group}}/{{dashify name}}'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-react-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-react-samples'

    # run_command "npx create-react-app ."

    # run_command 'code .' # run_command will ensure the folder exists

    # new_blueprint :bootstrap       , definition_subfolder: 'react', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
