# ------------------------------------------------------------
# Video deck for different sites
# ------------------------------------------------------------
KDsl.blueprint :video_deck do
  settings do
    name                          parent.key
    video_type                    'thought'
    theme                         'gratitude_bridge' # gratitude_bridge appy_dave beige black blood league moon night serif simple sky solarized white
    keyword                       'change_journal'
    short_file                    'video-deck'
    title                         'Video Deck'
    target_website                'gratitude_bridge'
    description                   '[Video Deck] is daily thought video'
    author                        'AppyDave'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/video/video-deck'
    publish_on                    ['youtube.com', 'facebook.com', 'linkedin.com']
    app_path                      '~/dev/idea_video/video_deck'
    data_path                     '_/.data'
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are Change journals?'
    row 'Why Do Change journals Work So Well?', points: []
    row 'Best Practices', points: [], aka: '7 Tips for Writing a Great change_journal'
    row 'What Not to Do', points: []
    row 'Conclusion', aka: 'Wrapping Up'
  end

  table :slides do
    fields %i[group h1_fit h2_fit h3_fit h1 h2 h3 p p1 p2 p3 i bo bsize t tspeed points fragments aka code code_format raw animate]

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Video Deck'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Video Deck',
      h2: 'is easy'

    row :b, i: 1, bsize: 'auto 99%'
    row :b, i: 1, bsize: 'auto 99%', bo: '.1', h1_fit: '<a>klueless-io</a>/handlebars-helpers', t: 'zoom-in'
  end

  def on_action
    # write_html 
    # write_json is_edit: true
  end
end
