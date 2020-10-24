# ------------------------------------------------------------
# Code Idea
# ------------------------------------------------------------

KDsl.microapp :ktg_know_thy_gem do
  s = settings do
    name                          parent.key
    app_type                      'Idea'
    new_app_type                  ''
    description                   'Ktg Know Thy Gem is an idea for'
    application                   'ktg_know_thy_gem'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'ktg_know_thy_gem'
    website                       'http://appydave.com/idea/ktg_know_thy_gem'
    affiliate_link                ''
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/idea/ktg_know_thy_gem'
    data_path                     '_/.data'
  end
  
  # ************************************************************
  # Know thy GEM is where I document gems
  # This file is where I list the GEMS to document
  # ************************************************************

  # A Guide to Choosing the Best Gems for Your Ruby Project
  # https://www.justinweiss.com/articles/a-guide-to-choosing-the-best-gems-for-your-ruby-project/

  # Versioning

  # Can you extract patterns of code from a GEM

  # Sources: https://bestgems.org/featured
  # Sources: https://www.ruby-toolbox.com/categories
  # Sources: https://rubygarage.org/blog/best-ruby-gems-we-use

  # https://docs.google.com/spreadsheets/d/1Rio0rjAucQgCw24S6kM7YCd4RzHUf-_J12WC3ytNnTU/edit#gid=0
  # This list needs to be deduplicated and queried for extra data
  # Use a spider

  # Latest version and download count can be read from rubygems.org URL
  table :gem_list do

    fields %i[group gem title source rubygems description]

    row 'version', 'semantic', 'semantic versioning', 'https://github.com/jlindsey/semantic', 'https://rubygems.org/gems/semantic', 'Semantic Version utility class for parsing, storing, and comparing versions. See: http://semver.org'

    row 'logging', 'logging', 'logging', 'https://rubygems.org/gems/logging', 'https://rubygems.org/gems/logging','Logging is a flexible logging library for use in Ruby programs based on the design of Javas log4j library.'
    row 'logging', 'logging-email', 'logging to email', 'https://github.com/TwP/logging-email', '',''

    row 'plugin' , 'little-plugger', 'logging to email', 'https://github.com/twp/little-plugger', 'https://rubygems.org/gems/little-plugger/versions/1.1.4','LittlePlugger is a module that provides Gem based plugin management'
    
    row 'generator' , 'bones', 'Generate new Ruby projects from a code skeletons', 'https://github.com/TwP/bones', 'https://rubygems.org/gems/bones', 'Mr Bones is a handy tool that creates new Ruby projects from a code skeleton. The skeleton contains some starter code and a collection of rake tasks to ease the management and deployment of your source code. Several Mr Bones plugins are available for creating git repositories, creating GitHub projects, running various test suites and source code analysis tools.'
    
  end

  table :gem_list do

  actions do
    # write_json is_edit: true
  end

end
