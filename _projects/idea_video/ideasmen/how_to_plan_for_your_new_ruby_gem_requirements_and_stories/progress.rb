# ------------------------------------------------------------
# Idea for a 'Listicle' style blog post
# ------------------------------------------------------------
KDsl.blueprint :how_to_plan_for_your_new_ruby_gem_requirements_and_stories do
  s = settings do
    name                          parent.key
    post_type                     ''
    keyword                       'ruby_gem'
    title                         'How To Plan For Your New Ruby Gem Requirements And Stories'
    target_website                'ideasmen'
    description                   '[How To Plan For Your New Ruby Gem Requirements And Stories] is a  article that will be written for the Ideasmen website'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/idea_video/how_to_plan_for_your_new_ruby_gem_requirements_and_stories'
    publish_on                    ['dev.to', 'quora.com', 'reddit.com', 'www.buzzfeed.com']
    app_path                      '~/dev/idea_video/how_to_plan_for_your_new_ruby_gem_requirements_and_stories'
    data_path                     '_/.data'
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are Ruby gems?'
    row 'Why Do Ruby gems Work So Well?', points: []
    row 'Best Practices', points: [], aka: '7 Tips for Writing a Great ruby_gem'
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

    row "Turning Ruby gem into abc"
  end

  def on_action
    # write_html 
    # write_json is_edit: true
  end
end

def src_url(key)
  sources = @data['sources']['rows']
  find_row = sources.find { |s| s['key'] == key }
  find_row.present? ? find_row['url'] : ''
end
