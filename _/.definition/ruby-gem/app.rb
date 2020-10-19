# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  s = settings do
    ruby_version                  '2.7.2' # Need a service that can return this information for me at the time of creating the project

    name                          parent.key
    app_type                      'Ruby Gem'
    description                   '{{titleize name}} is a Ruby GEM for '
    application                   '{{snake name}}'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/{{settings.website_slug}}/{{snake name}}'
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/{{settings.project_group}}/{{snake name}}'
    data_path                     '_/.data'
  end

  actions do
  end

end
