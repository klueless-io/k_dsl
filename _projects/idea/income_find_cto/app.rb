# ------------------------------------------------------------
# Code Idea
# ------------------------------------------------------------

KDsl.microapp :income_find_cto do
  s = settings do
    name                          parent.key
    app_type                      'Idea'
    new_app_type                  ''
    description                   'Income Find Cto is an idea for'
    application                   'income_find_cto'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      'income_find_cto'
    website                       'http://appydave.com/idea/income_find_cto'
    affiliate_link                ''
    main_story                    'As a Developer, I should be able to , so that I'
    app_path                      '~/dev/idea/income_find_cto'
    data_path                     '_/.data'
  end

  # ************************************************************
  # Find a CTO, Development Manager or CEO for a startup
  # Try Stack Overflow: https://stackoverflow.com/jobs?med=clc&clc-var=4
  # Then link up to these People on Linked-in
  # Regularly post content to linked-in on architecture and rapid development
  # Send them links to good work
  # Keep a record of these people and the fact that you have connected with them.
  # ************************************************************

  actions do
  end

end
