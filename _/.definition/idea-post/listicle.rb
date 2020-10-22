# ------------------------------------------------------------
# Idea for a 'Listicle' style blog post
# ------------------------------------------------------------

KDsl.blueprint :{{snake name}} do
  s = settings do
    name                          parent.key
    post_type                     '{{settings.post_type}}'
    keyword                       '{{settings.keyword}}'
    title                         '{{titleize name}}'
    target_website                '{{settings.target_website}}'
    description                   '[{{titleize name}}] is a {{titleize settings.post_type}} article that will be written for the {{titleize settings.target_website}} website'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/{{settings.website_slug}}/{{snake name}}'
    publish_on                    ['dev.to', 'quora.com', 'reddit.com', 'www.buzzfeed.com']
    app_path                      '~/dev/{{settings.project_group}}/{{snake name}}'
    data_path                     '_/.data'
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are {{titleize settings.keyword}}?'
    row 'Why Do {{titleize settings.keyword_plural}} Work So Well?', points: []
    row 'Best Practices', points: [], aka: '8 Tips for Writing a Great {{titleize settings.keyword}}'
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
