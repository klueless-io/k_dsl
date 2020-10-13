# frozen_string_literal: true

KDsl.microapp :spidy_expireddomains do
  settings do
    name                          "#{parent.key}"
    app_type                      'spider_javascript'
    description                   'Spidy ExpiredDomains is a spider for scraping data from expireddomains.net'
    application                   "#{parent.key}"
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    scrape_site                   'expireddomains.net'
    website                       "http://appydave.com/spider/#{parent.key}"
    main_story                    'As a Data Consumer, I should be able to retrieve data expireddomains.net, so that I find great domain names'
    app_path                      "~/dev/spider-js/#{parent.key}"
    data_path                     '_/.data'
  end

  actions do
    write_json is_edit: true
  end
end
