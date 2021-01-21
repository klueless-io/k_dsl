# ------------------------------------------------------------
# Idea for a new 'Listicle' style blog video
# ------------------------------------------------------------
KDsl.blueprint :thought do
  settings do
    name                          parent.key
    video_type                    'thought'
    keyword                       'change_journal'
    title                         'Change Journal Tim Jaudszims'
    target_website                'gratitude_bridge'
    description                   '[Change Journal Tim Jaudszims] is daily thought video'
    author                        'Gratitude Bridge'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/video/thought'
    publish_on                    ['youtube.com', 'facebook.com', 'linkedin.com']
  end

  table :slides do
    fields %i[group h1_fit h2_fit h3_fit h1 h2 h3 p p1 p2 p3 i bo bsize t tspeed points fragments aka code code_format raw animate]

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Change Journal Tim Jaudszims'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Change Journal Tim Jaudszims',
      h2: 'is easy'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Change Journal Tim Jaudszims',
      h2: 'then write some code ... <a>easy</a> peasy'

    row :intro, i: 1, bsize: '75% auto'

    row :intro, i: 1, bsize: '75% auto', bo: '.2',
      h2_fit: '<a>7</a> things to do before you<br/> <a>write</a> a line of code'

    row :intro, animate: :auto, t: 'none',
      h1_fit: '<a>Gem</a>&nbsp;&nbsp; handlebars-helpers'

    row :a, 'What are Ruby gems?', fragments: [
      'A <handlebars-helpers>Gem</handlebars-helpers> is packaged <a>Ruby</a> application or library.',
      'Gems can extend functionality in Ruby applications',
      '<br>The Gem am I building will provide extended functionality for <a>HandlebarsJS</a>',
    ]

    row :b, i: 1, bsize: 'auto 99%'
    row :b, i: 1, bsize: 'auto 99%', bo: '.1', h1_fit: '<a>klueless-io</a>/handlebars-helpers', t: 'zoom-in'
    row :b, i: 2, bsize: '60% auto', h2: '<br/><br/><br/><br/><br/><br/><a>inspired by</a>'
    row :b, i: 3, bsize: '60% auto'
    row :c, h1_fit: 'What is HandleBars?', i: 1, bo: '.1', t: 'zoom-in'
    row :c, i: 1
    row :c, i: 2
    row :c, i: 3

    row :b, i: 1, bsize: 'auto 99%', bo: '.1', h2_fit: 'My process when starting a <a>gem</a>?', t: 'zoom-in'
    
    row :e, i: 1, bsize: 'cover', animate: :auto, t: 'none'
  
    row :e, i: 1, bsize: 'cover', bo: '.5', animate: :auto, t: 'none',
      h2_fit: "Generate code using <a>DSL's</a><br/><br/><br/><br/><br/><br/>"
    
    row :e, i: 1, bsize: 'cover', bo: '.5', animate: :auto, t: 'none',
      h2_fit: "Generate code using DSL's",
      h3_fit: "DSL is short for <a>Domain Specific Language</a><br/><br/><br/><br/><br/><br/>"
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are Change journals?'
    row 'Why Do Change journals Work So Well?', points: []
    row 'Best Practices', points: [], aka: '7 Tips for Writing a Great change_journal'
    row 'What Not to Do', points: []
    row 'Conclusion', aka: 'Wrapping Up'
  end

  def on_action
    # write_html 
    # write_json is_edit: true
  end
end
