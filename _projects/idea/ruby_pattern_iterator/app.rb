# ------------------------------------------------------------
# Code Idea
# ------------------------------------------------------------

KDsl.microapp :ruby_pattern_iterator do
  s = settings do
    name                          parent.key
    app_type                      'Idea'
    new_app_type                  ''
    description                   'Ruby Pattern Iterator is an idea for'
    application                   'ruby_pattern_iterator'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'ruby_pattern_iterator'
    website                       'http://appydave.com/idea/ruby_pattern_iterator'
    affiliate_link                ''
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/idea/ruby_pattern_iterator'
    data_path                     '_/.data'
  end

  # ************************************************************
  # How do you add .each to a class and make it iteratable
  # GEM: loquacious/lib/loquacious/configuration/iterator.rb
  # ************************************************************
  
  actions do
  end

end
