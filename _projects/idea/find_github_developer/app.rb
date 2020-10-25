# ------------------------------------------------------------
# Code Idea
# ------------------------------------------------------------

KDsl.microapp :find_github_developer do
  s = settings do
    name                          parent.key
    app_type                      'Idea'
    new_app_type                  ''
    description                   'Find Github Developer is an idea for'
    application                   'find_github_developer'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'find_github_developer'
    website                       'http://appydave.com/idea/find_github_developer'
    affiliate_link                ''
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/idea/find_github_developer'
    data_path                     '_/.data'
  end

  # As a Developer, I want to search for great repositories on GitHub based a tag, e.g. Rails
  # I could use GPT3 for this

  def on_action
  end

end
