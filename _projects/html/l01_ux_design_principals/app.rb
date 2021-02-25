# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :l01_ux_design_principals do
  settings do
    name                          parent.key
    app_type                      'HTML App'
    title                         'L01 UX Design Principals'
    description                   'L01 UX Design Principals in HTML'
    application                   'L01UxDesignPrincipals'
    git_repo_name                 'L01UxDesignPrincipals'
    git_organization              'klueless-html-samples'
    avatar                        'UX Designer'
    main_story                    'As a UX Designer, I want to follow UX best practices, so that my applications give a great user experience'
    author                        'David Cruwys'
    author_email                  'david@ideasmen.com.au'
    copyright_date                '2021'
    website                       'http://appydave.com/html/samples/l01-ux-design-principals'
    application_lib_path          'L01UxDesignPrincipals'
    namespace_root                'L01UxDesignPrincipals'
    template_rel_path             'html'
    app_path                      '~/dev/html/L01UxDesignPrincipals'
    data_path                     '_/.data'
  end

  is_run = 1

  def on_action
    s = d.settings
    # github_del_repo s.git_repo_name, organization: 'klueless-html-samples'
    # github_new_repo s.git_repo_name, organization: 'klueless-html-samples'
    # run_command 'code .' # run_command will ensure the folder exists

    # new_blueprint :bootstrap       , definition_subfolder: 'html', output_filename: 'bootstrap.rb', f: false, show_editor: true
  end if is_run == 1

  L.warn 'set is_run to true if you want to run the action' if is_run == 0
end
