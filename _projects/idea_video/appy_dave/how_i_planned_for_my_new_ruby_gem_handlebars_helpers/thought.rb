# ------------------------------------------------------------
# Idea for a new video
# ------------------------------------------------------------
KDsl.blueprint :how_i_planned_for_my_new_ruby_gem_handlebars_helpers do
  settings do
    name                          parent.key
    video_type                    'thought'
    theme                         %W[appy_dave beige black blood league moon night serif simple sky solarized white].first
    keyword                       'ruby_gem'
    short_file                    'gem-handlebars-helpers'
    title                         'How I Planned for a New Ruby Gem - Handlebars Helpers'
    target_website                'appy_dave'
    description                   '[How I Planned For My New Ruby Gem Handlebars Helpers] is daily thought video where I share want is going on for me today with development'
    author                        'AppyDave'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/video/how-i-planned-for-my-new-ruby-gem-handlebars-helpers'
    publish_on                    ['youtube.com', 'facebook.com', 'linkedin.com']
    app_path                      '~/dev/idea_video/how_i_planned_for_my_new_ruby_gem_handlebars_helpers'
    data_path                     '_/.data'
  end

  table :slides do
    fields %i[group h1_fit h2_fit h3_fit h1 h2 h3 p p1 p2 p3 i bo bsize t tspeed points fragments aka code code_format raw animate]

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Creating a 12 step process'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Creating a 12 step process',
      h2: 'is easy'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Creating a 12 step process',
      code: '<a>bundle gem</a> --coc --test=rspec --mit my-cool-new-gem'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Creating a 12 step process',
      code: 'bundle gem --coc --mit --test=rspec <a>my-cool-new-gem</a>'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Creating a 12 step process',
      h2: 'then write some code ... <a>easy</a> peasy'

    row :intro, i: 1, bsize: '75% auto'

    row :intro, i: 1, bsize: '75% auto', bo: '.2',
      h2_fit: '<a>7</a> things to do before you<br/> <a>write</a> a line of code'

    row :intro, animate: :auto, t: 'none',
      h1_fit: '<a>Gem</a>&nbsp;&nbsp; handlebars-helpers'

    row :intro, animate: :auto, t: 'none',
      h1_fit: 'Gem&nbsp;&nbsp; handlebars-helpers',
      h2_fit: 'How I set myself up <a>before</a> writing any code.'

        <<~TEXT
  Overview
  Inspiration
  Stretch Goal
    GPT3

Software Factory for code workflow automation
  DSL - Domain Specific Language

Stories
  - Setup a new Gem
  Stretch Goal
    GPT3


TEXT

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

    row :e, raw: <<~HTML

      <section
        data-auto-animate
        data-background ='e-01.png'
        data-transition = 'fade-in'
        data-transition-speed='fast'
        data-background-size='cover'>

        <img data-id="1" src='e-03.png' data-id="1" style="position: absolute; top: 270px; left: 450px; width: 300px; z-index: 1; max-width: unset; max-height: unset;" />
        <img data-id="2" src='e-04.png' data-id="1" style="position: absolute; top: 320px; left: 550px; width: 300px; z-index: 3; max-width: unset; max-height: unset;" />
        <img data-id="3" src='e-05.png' data-id="1" style="position: absolute; top: 400px; left: 500px; width: 300px; z-index: 2; max-width: unset; max-height: unset;" />
      </section>

      <section
        data-auto-animate
        data-background ='e-01.png'
        data-transition-speed='fast'
        data-background-size='cover'
        data-background-opacity='.3'>

        <img data-id="1" src='e-03.png' data-id="1" style="position: absolute; top: 0px; left: -50px; width: 1100px; z-index: 9; max-width: unset; max-height: unset;" />
        <img data-id="2" src='e-04.png' data-id="1" style="position: absolute; top: 320px; left: 550px; width: 300px; z-index: 3; max-width: unset; max-height: unset;" />
        <img data-id="3" src='e-05.png' data-id="1" style="position: absolute; top: 400px; left: 500px; width: 300px; z-index: 2; max-width: unset; max-height: unset;" />
      </section>

      <section
        data-auto-animate
        data-background ='e-01.png'
        data-transition-speed='fast'
        data-background-size='cover'
        data-background-opacity='.3'>

        <img data-id="1" src='e-03.png' data-id="1" style="position: absolute; top: 270px; left: 450px; width: 300px; z-index: 1; max-width: unset; max-height: unset;" />
        <img data-id="2" src='e-04.png' data-id="1" style="position: absolute; top: 0px; left: -50px; width: 1100px; z-index: 9; max-width: unset; max-height: unset;" />
        <img data-id="3" src='e-05.png' data-id="1" style="position: absolute; top: 400px; left: 500px; width: 300px; z-index: 2; max-width: unset; max-height: unset;" />
      </section>

      <section
        data-auto-animate
        data-background ='e-01.png'
        data-transition = 'fade-in'
        data-transition-speed='fast'
        data-background-size='cover'>

        <img data-id="1" src='e-03.png' data-id="1" style="position: absolute; top: 270px; left: 450px; width: 300px; z-index: 1; max-width: unset; max-height: unset;" />
        <img data-id="2" src='e-04.png' data-id="1" style="position: absolute; top: 320px; left: 550px; width: 300px; z-index: 3; max-width: unset; max-height: unset;" />
        <img data-id="3" src='e-05.png' data-id="1" style="position: absolute; top: 0px; left: -50px; width: 1100px; z-index: 9; max-width: unset; max-height: unset;" />
      </section>

    HTML
    
    # row :e, i: 2, bsize: 'contain'
    # row :e, i: 3, bsize: 'auto 93%'

    # row :c, 'Why do Ruby gems Work So Well?', points: []
    # row :d, 'Best Practices', points: [], aka: '7 Tips for Writing a Great ruby_gem'
    # row :e, 'What Not to Do', points: []
    # row :g, 'Conclusion', aka: 'Wrapping Up'
  end

  def on_action
    app = import(:thought, :microapp)
    custom_data = OpenStruct.new(microapp: app,
                                 settings: d.settings,
                                 slides: d.slides.rows)

    source_path = File.expand_path(app.settings.app_path)
    template_file = File.join(source_path, 'presentation-root.html')
    test_file = File.join(source_path, 'xmen.html')

    target_path = "/Users/davidcruwys/dev/slides/presentation/#{custom_data.settings.title.parameterize.dasherize}"
    output_file = File.join(target_path, "#{custom_data.settings.short_file}.html")

    copy_images(source_path, target_path)

    custom_data.slides.each do |slide|
      file = "#{slide.group}-#{slide.i.to_s.rjust(2, '0')}.png"
      full_file = File.join(target_path, file)

      slide.image_name = file if File.exist?(full_file)
      
      slide.bo = '1' if slide.bo.nil?
      slide.background_opacity = slide.bo
      slide.bsize = 'cover' if slide.bsize.nil?
      slide.background_size = slide.bsize
      
      slide.t = 'zoom' if slide.t.nil?
      slide.transition = slide.t
      slide.tspeed = 'slow' if slide.tspeed.nil?
      slide.transition_speed = slide.tspeed

      slide.code_format = 'ruby' if slide.code_format.nil?
    end

    write_html(is_edit: false,
               custom_data: custom_data,
               template_file: template_file,
               output_file: test_file)

    write_html(is_edit: true,
               custom_data: custom_data,
               template_file: template_file,
               output_file: output_file)
                
    L.warn '-' * 100
    # write_json is_edit: true, custom_data: custom_data
  end

  def copy_images(source_path, target_path)
    FileUtils.mkdir_p(target_path)

    dir = Dir[File.join(source_path, '*.png')]
    dir.each do |filename|
      FileUtils.cp(filename, target_path)
    end
  end
end
