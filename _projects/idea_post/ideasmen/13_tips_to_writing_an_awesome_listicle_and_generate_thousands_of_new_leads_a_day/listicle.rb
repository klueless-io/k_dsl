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
    website                       'http://appydave.com/idea_post/13_tips_to_writing_an_awesome_listicle_and_generate_thousands_of_new_leads_a_day'
    publish_on                    ['dev.to', 'quora.com', 'reddit.com', 'www.buzzfeed.com']
    app_path                      '~/dev/idea_post/13_tips_to_writing_an_awesome_listicle_and_generate_thousands_of_new_leads_a_day'
    data_path                     '_/.data'
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are Listicles?'
    row 'Why Do Listicles Work So Well?', points: [
      'People are in a hurry',
      'Easy to Write',
      'Easy to Preview',
      'Simple or Comprehensive',
    ]
    row 'Best Practices', points: [
      'Choose a Format For Your Listicle',
      '10 is the ultimate number, 5 is great, 3,4 & 7 and 20 are good',
      'Use numerals, 10 not Ten',
      'Choose a Topic',
      'Use BuzzSumo',
      'Use a power word [”tips”, “top”, “best”, “ways”, “steps”]',
      'Use double barreled headlines',
      'Your Own Expertise',
      'Surprise Your Readers',
      'Put A List In Your List',
      'Mention Famous People In Your Listicle',
      'Keywords',
      'Create a Roundup With Influencers',
      'Pro Tip: '
    ], aka: '8 Tips for Writing a Great Listicle'
    row 'What Not to Do', points: [
      'A horrible title',
      'Lack of relevance',
      'Vague content',
      'No ending',
      'Low-quality writing'
    ]
    row 'Conclusion', aka: 'Wrapping Up'
  end

  table :sources do
    fields %i[key title note url]

    row 'glean'         , '10 Tips to Write Better Listicles for Content Marketing', 'more :research needed', 'https://glean.info/7-tips-to-write-better-listicles-for-content-marketing'
    row 'backlinko'     , 'Blogging and Written Content - Listicles', 'more :research needed', 'https://backlinko.com/hub/content/listicles'

    row 'prdaily'       , '7 guidelines for content marketers to craft winning listicles', 'this seems to have the same info as GLEAN, someone is coping', 'https://www.prdaily.com/7-guidelines-for-content-marketers-to-craft-winning-listicles/'
    row 'crowdcontent'  , 'How to Write a Great Listicle for 2020', 'more :research needed', 'https://www.crowdcontent.com/blog/2019/12/10/how-to-write-a-great-listicle-for-2020/'
    row 'civicwebmedia' , '10 reasons you should have 10 items in your listicle titles', 'more :research needed', 'https://www.civicwebmedia.com.au/10-reasons-you-should-have-10-items-in-your-listicle-titles/'
    row 'venngage'      , 'Why 10 Is Actually The Best Number To Use In Blog Titles', 'more :research needed', 'https://venngage.com/blog/blog-titles/'
    row 'vegibit'       , '14 Steps To Write A Great Listicle', 'could be outdated, but put a list in your list was good and Mention Famous People In Your Listicle', 'https://vegibit.com/how-to-write-a-listicle/'
    row 'hubspot'       , 'How to Write a Listicle [+ Examples and Ideas]', 'more :research needed', 'https://blog.hubspot.com/blog/tabid/6307/bid/32105/the-top-10-qualities-of-high-quality-list-posts.aspx'
    row 'bustle'        , '8 Tips For Writing A Listicle For Publication', 'more :research needed', 'https://www.bustle.com/articles/134854-8-tips-for-writing-a-listicle-that-will-get-published'
    row 'composely'     , '7 Tips for Writing a Great Listicle', 'more :research needed', 'https://compose.ly/for-writers/7-tips-for-writing-a-great-listicle/'
    row 'process'       , 'Writing a Listicle: The 11-Step Guide and Why They’re Awesome', 'more :research needed', 'https://www.process.st/listicle/'
  end

  table :research do
    fields %i[source title description]

    row src_url('glean')    , 'Why Readers Love Listicles'        , 'Our brains seem inherently attracted to lists. Numbers in listicle headlines stand out in a sea of text search results. With their defined limit and structured organization, they’re easily digestible. The format helps us absorb and retain information. Rather than being overwhelmed with complex, extensive information, we prefer to learn in bite-sized nuggets. They also appeal to our desire to categorize things.'
    row src_url('glean')    , 'Different styles of listicles'     , 'Listicles have different styles that are appropriate for different purposes and audiences. According BuzzFeed, those styles are: Standard lists, Definitive list, Framework list'
    row src_url('glean')    , 'Remember the conclusion.'          , 'Listicles frequently have weak conclusions or no conclusions and end abruptly'
    row src_url('backlinko'), 'Styles'                            , 'The Simple List, The Expanded List Post, “Best of” List Posts, Curated Influencer Quotes'
  end

  table :extra_ideas do
    fields %i[title description]

    row 'Tools for generating listicles'
    row 'Scraping for listicles'
    row 'Expanding a listicle from name+url to, name, url, 5 point description, image and video'
    row 'Turning listicles into slideshows'
    row 'Turning listicles into keynote'
    row 'Turning listicles into videos'
    row 'Turning listicles into instagram images'
    row 'Turning listicles into pinterest images'
    row 'Turning listicles into a linkedin post'
    row 'Turning listicles into a quora post'
    row 'Turning listicles into a redit post'
    row 'Turning listicles into a medium article'
    row 'Turning listicles into an infographic'
    row 'Turning listicles into an animated gif'
  end

  actions do
    # write_html 
    # write_json is_edit: true
  end
end

def src_url(key)
  sources = @data['sources']['rows']
  find_row = sources.find { |s| s['key'] == key }
  find_row.present? ? find_row['url'] : ''
end
