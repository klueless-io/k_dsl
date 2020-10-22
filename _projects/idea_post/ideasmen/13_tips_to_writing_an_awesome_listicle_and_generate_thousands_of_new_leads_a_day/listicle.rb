# ------------------------------------------------------------
# Idea for a 'Listicle' style blog post
# ------------------------------------------------------------

KDsl.blueprint :13_tips_to_writing_an_awesome_listicle_and_generate_thousands_of_new_leads_a_day do
  s = settings do
    name                          parent.key
    post_type                     'listicle'
    keyword                       'listicle'
    title                         '13 Tips To Writing An Awesome Listicle And Generate Thousands Of New Leads A Day'
    target_website                'ideasmen'
    description                   '[13 Tips To Writing An Awesome Listicle And Generate Thousands Of New Leads A Day] is a Listicle article that will be written for the Ideasmen website'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '13_tips_to_writing_an_awesome_listicle_and_generate_thousands_of_new_leads_a_day'
    website                       'http://appydave.com/idea_post/13_tips_to_writing_an_awesome_listicle_and_generate_thousands_of_new_leads_a_day'
    publish_on                    ['dev.to', 'quora.com', 'reddit.com', 'www.buzzfeed.com']
    app_path                      '~/dev/idea_post/13_tips_to_writing_an_awesome_listicle_and_generate_thousands_of_new_leads_a_day'
    data_path                     '_/.data'
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are Listicle?'
    row 'Why Do  Work So Well?', points: []
    row 'Best Practices', points: [], aka: '8 Tips for Writing a Great Listicle'
    row 'What Not to Do', points: []
    row 'Conclusion', aka: 'Wrapping Up'
  end

  table :sources do
    fields %i[key title note url]

    row 'xxx'           , '', '', 'http://xxx.com/somepath'
  end

  table :research do
    fields %i[source title description]

    row src_url('xxx')      , '', ''
  end

  table :extra_ideas do
    fields %i[title description]

    row "Turning #{f.humanize settings.main_keyword} into abc"
  end

  actions do
    # write_html 
  end

end

def src_url(key)
  sources = @data['sources']['rows']
  find_row = sources.find { |s| s['key'] == key }
  find_row.present? ? find_row['url'] : ''
end
