# frozen_string_literal: true

KDsl.microapp :spidy_expireddomains do
  settings do
    name                          'kp.k_key.to_s' # have I got this concept in place?
    app_type                      'spider_javascript'
    description                   'Spidy ExpiredDomains is a spider for scraping data from expireddomains.net'
    application                   'spidy_expireddomains'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    scrape_site                   'expireddomains.net'
    website                       'http://appydave.com/spider/spidy_expireddomains'
    main_story                    'As a Data Consumer, I should be able to retrieve data expireddomains.net, so that I find great domain names'
    app_path                      '~/dev/spider-js/spidy_expireddomains'
    data_path                     '_/.data'
  end
end
