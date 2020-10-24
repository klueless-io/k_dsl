# ------------------------------------------------------------
# Code Idea
# ------------------------------------------------------------

KDsl.microapp :ruby_pattern_configuration do
  s = settings do
    name                          parent.key
    app_type                      'Idea'
    new_app_type                  ''
    description                   'Ruby Pattern Configuration is an idea for'
    application                   'ruby_pattern_configuration'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'ruby_pattern_configuration'
    website                       'http://appydave.com/idea/ruby_pattern_configuration'
    affiliate_link                ''
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/idea/ruby_pattern_configuration'
    data_path                     '_/.data'
  end

  # ************************************************************
  # How do you build out dynamic configuration pattern or GEM
  # GEM: loquacious/lib/loquacious/configuration.rb
  # ************************************************************

  
  actions do
  end

end
