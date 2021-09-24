# ------------------------------------------------------------
# Idea for a new video
# ------------------------------------------------------------
KDsl.blueprint :printspeak_architecture do

  # /Users/davidcruwys/dev/kgems/k_dsl/_projects/idea_video/printspeak/presentation-sample.html

  dsl_root            = '~/dev/kgems/k_dsl/_projects/idea_video/printspeak'
  presentation_root   = '~/dev/printspeak/documentation/_/presentation'
  presentation_path   = File.join(presentation_root, 'printspeak-architecture')
  original_reveal_js  = '~/dev/slides/'

  settings do
    name                          parent.key
    video_type                    'thought'
    theme                         %W[printspeak sky appy_dave beige black blood league moon night serif simple sky solarized white].first
    keyword                       'rails architecture'
    short_file                    'printspeak-architecture'
    title                         'PrintSpeak Architecture'
    target_website                'printspeak'
    description                   'PrintSpeak Architecture, Patterns and Code Generation'
    author                        'AppyDave'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/video/printspeak-architecture'
    publish_on                    ['youtube.com', 'facebook.com', 'linkedin.com']
    app_path                      dsl_root
    dsl_code_path                 File.join(dsl_root, 'template_code')
    dsl_image_path                File.join(dsl_root, 'images')
    dsl_reveal_js_dist            File.join(original_reveal_js, 'dist' )
    dsl_reveal_js_plugin          File.join(original_reveal_js, 'plugin' )
    target_path                   presentation_path
    target_image_path             File.join(presentation_path, 'images')
    target_reveal_js_dist         File.join(presentation_root, 'dist')
    target_reveal_js_plugin       File.join(presentation_root, 'plugin')
    highlight_css_path            File.join(presentation_root, 'highlight_css')
    highlight_css_relative_path   '../highlight_css'
  end

  # Goals
  # Code to Images
  # Images to Files
  # Files to Slides

  # Code audit
  # Generated code in master
  # Code generator (entity_all)
  # Look at a few builder use cases

  def a(value)
    "<a>#{value}</a>"
  end

  table :slides do
    fields %i[group h1_fit h2_fit h3_fit h1 h2 h3 p p1 p2 p3 i bo bsize t tspeed points fragments aka code code_format code_lines code_file code_file_lines raw animate image_name]

    # row :xxx, i: 1, animate: :auto, t: 'none',
    # h1_fit: 'h1 fit',
    # h2: 'h2',
    # h2_fit: 'h2 fit',
    # h3: 'h3',
    # h3_fit: 'h3 fit',
    # p: 'the quick brown <a>fox</a> jumped over the lazy <a>dog</a>',
    # p2: 'paragraph2',
    # p3: 'paragraph3',
    # fragments: ['<a>1</a> duck', '<a>2</a> dogs', '3 cows']

    # row :intro, i: 1, animate: :auto, t: 'none'

    # row :intro, i: 1, animate: :auto, t: 'zoom-in', bo: '.2',
    #   h1: 'PrintSpeak'

    # row :intro, i: 1, animate: :auto, t: 'zoom-in', bo: '.2',
    #   h1: 'PrintSpeak',
    #   h2: 'Architecture Ideas'

    # row h1: 'Goal', t: 'none', fragments: [
    #   'Move from Rails 4 to 5, 6 and 7',
    #   'Robust code base with tests',
    #   'Strong cohesion, loose coupling'
    # ]

    # row :overview, i: 1, bsize: '50% auto', bo: '.1', animate: :auto, t: 'none',
    #   h1: 'Overview'

    # row :overview, i: 1, bsize: '50% auto', bo: '1', animate: :auto, t: 'none'

    # row :observation, i: 1, bsize: '50% auto', bo: '.1', animate: :auto, t: 'none',
    #   h1: 'Observations'

    # row :observation, i: 1, bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'

    # row :observation, i: 2, bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'

    # row animate: :auto, t: 'none',
    #   h3: 'Base Presenter',
    #   code_file: 'base_presenter.rb'

    # row animate: :auto, t: 'none',
    #   h3: 'Base Presenter',
    #   code_file: 'base_presenter.rb',
    #   code_file_lines: [1, *(2..15), 29]

    # row animate: :auto, t: 'none',
    #   h3: 'Base Presenter more',
    #   code_file: 'base_presenter.rb',
    #   code_file_lines: [1, *(17..28), 29]

    row image_name: 'images/code-campaign-spec-1.rb.png', h2: 'Code audit on <a>campaign.rb</a>', bsize: '30% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-spec-1.rb.png', h2: 'Campaign - Fat Model', bsize: '30% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-spec-1.rb.png', h2: 'Campaign - Fat Model', h3: '<a>82</a> methods, <a>1300</a> lines', bsize: '30% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: ['Including Rails DSL methods', 'scope<br/>belongs_to<br/>has_one<br/>has_many']
    row image_name: 'images/code-campaign-spec-1.rb.png', bsize: '30% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: [a('DSL methods')]
    row image_name: 'images/code-campaign-spec-2.rb.png', bsize: '30% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: [a('Read only methods')]
    row image_name: 'images/code-campaign-spec-3.rb.png', bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: [a('Operations'), a('Queries / Presenters'), a('Commands / Async Jobs')]
    row image_name: 'images/code-campaign-01-thin-1.rb.png', h3: 'Campaign - Thin Model', bsize: '70% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-01-thin-1.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-01-thin-2.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-0.rb.png', h3: 'Campaign - Virtual Fields  <br /> <a>readonly</a> fields', bsize: '45% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-0.rb.png', bsize: '45% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-1b-count.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: [a('count records')]
    row image_name: 'images/code-campaign-04-1b-count.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-2b-lookup.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: [a('lookup single records')]
    row image_name: 'images/code-campaign-04-2b-lookup.rb.png', h2: 'Why would we care?', bsize: '60% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-2b-lookup.rb.png', h2: 'Why would we care?', h3: 'Patterns', bsize: '60% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: ['different patterns require different tests', 'data setup is based on patterns', 'what you test is based on patterns', 'pattern tags can be used for code generation']
    row image_name: 'images/code-campaign-04-2b-lookup.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-2c-lookup.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-3b-predicate.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: [a('predicates return true/false')]
    row image_name: 'images/code-campaign-04-3b-predicate.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-3c-predicate.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-3d-predicate.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-4b.rb.png', bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-4b.rb.png', h3: 'Policy vs Predicate', bsize: '50% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow', fragments: ['policy is a type of predicate', 'policy also known as <a>access grant</a>', 'policies are related to authorization', 'policies are are cross-cutting concerns']
    row image_name: 'images/code-campaign-04-4b.rb.png', bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-5a-validation-0.rb.png', h3: a('Validators'), bsize: '60% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-5a-validation-0.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-5a-validation-2a.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-5a-validation-2b.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-5a-validation-2c.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-04-5a-validation-9.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/base_presenter.rb.png', h3: '<a>Presenters</a>', bsize: '60% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/base_presenter.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-click-statistics-0.rb.png', h3: 'Click Statistics - Presenter <br/><a>combined</a> query/present', bsize: '50% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-click-statistics-0.rb.png', bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-click-statistics-2-1.rb.png', bsize: '45% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-click-statistics-2-2.rb.png', bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-click-statistics-2-3.rb.png', bsize: '40% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-click-statistics-9.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-0.rb.png', h3: 'Contacts - Presenter <br/><a>separated</a> query/present', bsize: '45% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-0.rb.png', bsize: '45% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-2.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-2a.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-2b.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-2c.rb.png', bsize: '60% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-05-action-contact-9.rb.png', bsize: '50% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-08-decorator-campaign-0.rb.png', h3: 'Decorators', bsize: '80% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-08-decorator-campaign-0.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-08-decorator-campaign-2.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-08-decorator-campaign-9.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'

    row image_name: 'images/code-campaign-06-action-check-bounce-rate-0.rb.png', h3: 'Commands', bsize: '55% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-0.rb.png', bsize: '55% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-1.rb.png', h3: 'Check Bounce Rate - <a>Command</a>', bsize: '40% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-1.rb.png', bsize: '40% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-1a.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-1b.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-1c.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-06-action-check-bounce-rate-9.rb.png', bsize: '70% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'

    row image_name: 'images/code-campaign-07-job-resend-messages-0.rb.png', h3: 'Async Jobs', bsize: '80% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-07-job-resend-messages-0.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-07-job-resend-messages-2.rb.png', h3: 'Resend Messages - <a>Job</a>', bsize: '80% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-07-job-resend-messages-2.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-07-job-resend-messages-9.rb.png', bsize: '80% auto', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    row image_name: 'images/code-campaign-spec-1.rb.png', h2: 'Code audit on <a>campaign.rb</a> - end', bsize: '30% auto', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
  end
  
  def build_code_sample_slides_template
    <<-TEMPLATE
    {{#each samples}}
      {{#if show_slide_title}}
      row image_name: 'images/{{target_filename}}', h3: '{{{title}}}', bsize: '{{bsize}}', bo: '.2', animate: :auto, t: 'zoom-in', tspeed: 'slow'
      {{/if}}
      row image_name: 'images/{{target_filename}}', bsize: '{{bsize}}', bo: '1', animate: :auto, t: 'zoom-in', tspeed: 'slow'
    {{/each}}
    TEMPLATE
  end

  def on_action_execute(custom_data, template_file, test_file, output_file)
    # write_clipboard(template: build_code_sample_slides_template, custom_data: { samples: custom_data.code_samples } ) # .take(5)

    write_html(is_edit: false,
               custom_data: custom_data,
               template_file: template_file,
               output_file: test_file)

    write_html(is_edit: false,
               custom_data: custom_data,
               template_file: template_file,
               output_file: output_file)
                
    L.warn '-' * 100
    # write_json is_edit: true, custom_data: custom_data
  end

  def on_action
    sync_highlight_css(d.settings.highlight_css_path)

    # app = import(:thought, :microapp)
    custom_data = OpenStruct.new(settings: d.settings,
                                 slides: d.slides.rows,
                                 code_samples: d.code_samples.rows,
                                 custom_highlight: sync_highlight_css_link(d.settings.highlight_css_relative_path))

    target_path = File.expand_path(d.settings.target_path)
    
    source_path = File.expand_path(d.settings.app_path)
    template_file = File.join(source_path, 'presentation-root.html')
    test_file = File.join(source_path, 'presentation-sample.html')
    dsl_code_path = File.expand_path(d.settings.dsl_code_path)

    # L.kv 'target_path', target_path
    output_file = File.join(target_path, "#{custom_data.settings.short_file}.html") 

    # L.kv 'output_file', output_file
    # L.kv 'test_file', test_file

    dsl_reveal_js_dist = File.expand_path(File.join(d.settings.dsl_reveal_js_dist, '.'))
    target_reveal_js_dist = File.expand_path(d.settings.target_reveal_js_dist)

    sync_folders(dsl_reveal_js_dist, target_reveal_js_dist)

    dsl_reveal_js_plugin = File.expand_path(File.join(d.settings.dsl_reveal_js_plugin, '.'))
    target_reveal_js_plugin = File.expand_path(d.settings.target_reveal_js_plugin)

    sync_folders(dsl_reveal_js_plugin, target_reveal_js_plugin)

    copy_images(source_path, target_path)

    custom_data.code_samples.each do |code_sample|
      code_sample.title.strip!
      code_sample.target_filename = code_sample.filename if code_sample.target_filename.nil?
      code_sample.target_filename = "#{code_sample.target_filename}.png"

      code_sample.source_path     = File.join(d.settings.dsl_code_path, 'audit') if code_sample.source_path_name == 'default'
      code_sample.source_file     = File.expand_path(File.join(code_sample.source_path, code_sample.filename))
      code_sample.target_file1    = File.expand_path(File.join(d.settings.dsl_image_path, code_sample.target_filename))
      code_sample.target_file2    = File.expand_path(File.join(d.settings.target_image_path, code_sample.target_filename))
      code_sample.content         = File.read(code_sample.source_file)
      code_sample.content         = grab_content_lines(code_sample.content, code_sample.lines) unless code_sample.lines.length.zero?
    end

    process_code_samples(custom_data.code_samples)

    custom_data.slides.each do |slide|
      file = "#{slide.group}-#{slide.i.to_s.rjust(2, '0')}.png"
      full_file = File.join(target_path, file)

      slide.image_name = file if File.exist?(full_file)
      
      slide.bo = '1' if slide.bo.nil?
      slide.background_opacity = slide.bo
      slide.bsize = 'cover' if slide.bsize.nil?
      slide.background_size = slide.bsize
      
      slide.t = 'zoom' if slide.t.nil?``
      slide.transition = slide.t
      slide.tspeed = 'slow' if slide.tspeed.nil?
      slide.transition_speed = slide.tspeed
      
      slide.code_format = 'ruby' if slide.code_format.nil?

      unless slide.code_file.nil?
        file_path = File.join(dsl_code_path, slide.code_file)
        slide.code = File.exist?(file_path) ? File.read(file_path) : "#{file_path} not found"

        slide.code = grab_content_lines(slide.code, slide.code_file_lines)
      end
    end

    on_action_execute(custom_data, template_file, test_file, output_file)
  end

  def process_code_samples(code_samples)
    samples = code_samples.select { |sample| sample.action > 0 }

    L.error('RayCast can only process one image at a time')     if samples.length > 1
    return if samples.length != 1

    sample = samples.first

    create_code_image(sample)               if sample.action == 1
    save_code_image(sample)                 if sample.action == 2

    if sample.action == 9
      create_code_image(sample)
      sleep 6
      save_code_image(sample)
    end  
  end

  def create_code_image(code_image)
    L.block(code_image.content)

    pbcopy(code_image.content)

    `~/helper-scripts/create-image-from-code.sh ruby '#{code_image.title}'`
  end

  def save_code_image(code_image)
    download_file = File.join('/Users/davidcruwys/Downloads', "#{code_image.title}.png")

    FileUtils.mkdir_p(File.dirname(code_image.target_file1))
    FileUtils.mkdir_p(File.dirname(code_image.target_file2))

    FileUtils.cp(download_file, code_image.target_file1)
    FileUtils.cp(download_file, code_image.target_file2)
    FileUtils.rm(download_file)
  end

  def copy_images(source_path, target_path)
    FileUtils.mkdir_p(target_path)

    dir = Dir[File.join(source_path, '*.png')]
    dir.each do |filename|
      FileUtils.cp(filename, target_path)
    end
  end

  def sync_folders(source_path, target_path)
    FileUtils.cp_r File.join(source_path, "."), target_path
  end

  def sync_highlight_css_link(highlight_css_relative_path)
    css = d.highlight_css.rows.select { |row| row.active == 1 }.first
    
    return nil if css.nil?

    relative_css_file = File.join(highlight_css_relative_path, css.filename)

    "<link rel='stylesheet' href='#{relative_css_file}'>"
  end

  # DONE
  def sync_highlight_css(highlight_css_path, force: false)
    css_list = d.highlight_css.rows.select { |row| row.active == 1 }

    css_list.each do |css|
      local_css_file = File.expand_path(File.join(highlight_css_path, css.filename))
      L.kv 'path', local_css_file
      L.kv 'found?', File.exist?(local_css_file)
      L.kv 'url', css.url

      download_highlight_css(local_css_file, css.url) if force || !File.exist?(local_css_file)
    end
  end

  def download_highlight_css(local_css_file, url)
    content = Net::HTTP.get(URI.parse(url))
    
    File.write(local_css_file, content)

    L.info "Write to file #{local_css_file}"
  end

  # based on uc_grab_lines(content, lines_to_include) from rspec_usecases
  def grab_content_lines(content, lines_to_include)
    return content if lines_to_include.nil?

    content_lines = content.lines

    line_nos = lines_to_include.sort.collect

    L.error 'Line numbers must start from 1' if line_nos.min < 1

    L.error "Line number out of range - content_length: #{content_lines.length} - line_no: #{line_nos.max}" if content_lines.length <= line_nos.max - 1

    output_lines = line_nos.map { |line_no| content_lines[line_no - 1].chomp }

    output_lines.join("\n")
  end

  table :code_samples do

    # actions: 1 = make image using ray trace, 2 = copy image to file, 3 = build DSL
    fields [:action, :title, :filename, :target_filename, f(:source_path_name, :default), f(:lines, []), f(:show_slide_title, true), f(:bsize, '80% auto')]

    # row 9
    row 0, 'Campaign - <a>82</a> methods, <a>1300</a> lines'  , 'code-campaign-spec.rb'             , 'code-campaign-spec-1.rb', bsize: '30% auto', lines: [*(2..39)]
    row 0, 'Campaign - (82 methods, 1300 lines)'  , 'code-campaign-spec.rb'             , 'code-campaign-spec-2.rb', bsize: '30% auto', lines: [*(41..89)], show_slide_title: false
    row 0, 'Campaign - (82 methods, 1300 lines)'  , 'code-campaign-spec.rb'             , 'code-campaign-spec-3.rb', bsize: '50% auto', lines: [*(91..123)], show_slide_title: false
    # row 0, ''                                           , 'code-campaign.rb'
    row 0, 'Campaign - Thin Model'                      , 'code-campaign-01-thin.rb'          , 'code-campaign-01-thin-1.rb', bsize: '70% auto', lines: [1,2,*(3..18),37]
    row 0, 'Campaign - Thin Model'                      , 'code-campaign-01-thin.rb'          , 'code-campaign-01-thin-2.rb', bsize: '60% auto', lines: [1,2, *(20..36), 37], show_slide_title: false
    # row 0, 'Campaign - Thin Model'                      , 'code-campaign-01-thin.rb'          , 'code-campaign-01-thin-3.rb', lines: [1,2, *(14..17), *(28..37)], show_slide_title: false
    # row 0, 'Campaign - Scopes'                          , 'code-campaign-03.rb'                   , show_slide_title: false
    row 0, 'Campaign - Virtual Fields  <br /> <a>readonly</a> fields', 'code-campaign-04-0.rb'             , bsize: '45% auto'
    # row 0, 'Campaign - Count'                           , 'code-campaign-04-1a-count.rb'          , show_slide_title: false
    row 0, 'Campaign - Count (implementation)'          , 'code-campaign-04-1b-count.rb'          , show_slide_title: false
    # row 0, 'Campaign - Lookup'                          , 'code-campaign-04-2a-lookup.rb'         , show_slide_title: false
    row 0, 'Campaign - Lookup (implementation)'         , 'code-campaign-04-2b-lookup.rb'         , show_slide_title: false, bsize: '60% auto'
    row 0, 'Campaign - Lookup (wrong location)'         , 'code-campaign-04-2c-lookup.rb'         , show_slide_title: false, bsize: '60% auto'
    # row 0, 'Campaign - Predicate'                       , 'code-campaign-04-3a-predicate.rb'      , show_slide_title: false
    row 0, 'Campaign - Predicate (implementation)'      , 'code-campaign-04-3b-predicate.rb'      , show_slide_title: false, bsize: '60% auto'
    row 0, 'Campaign - Predicate (wrong location)'      , 'code-campaign-04-3c-predicate.rb'      , show_slide_title: false, bsize: '70% auto'
    row 0, 'Campaign - Predicate (refactor)'            , 'code-campaign-04-3d-predicate.rb'      , show_slide_title: false, bsize: '70% auto'
    # row 0, 'Campaign - Policy'                          , 'code-campaign-04-4a.rb'                , show_slide_title: false
    row 0, 'Campaign - Policy (implementation)'         , 'code-campaign-04-4b.rb'                , show_slide_title: false, bsize: '50% auto'
    row 0, 'Campaign - Custom Validations'              , 'code-campaign-04-5a-validation-0.rb'   , show_slide_title: false, bsize: '60% auto'
    row 0, 'LocalCampaignNameValidator'                 , 'code-campaign-04-5a-validation-2a.rb'  , show_slide_title: false
    row 0, 'GlobalCampaignNameValidator'                , 'code-campaign-04-5a-validation-2b.rb'  , show_slide_title: false
    row 0, 'Both Validators'                            , 'code-campaign-04-5a-validation-2c.rb'  , show_slide_title: false, bsize: '60% auto'
    row 0, 'Validator Usage'                            , 'code-campaign-04-5a-validation-9.rb'   , show_slide_title: false
    row 0, '<a> nters</a>'                          , 'base_presenter.rb', bsize: '60% auto'
    row 0, 'Click Statistics - Presenter <br/><a>combined</a> query/present', 'code-campaign-05-action-click-statistics-0.rb', bsize: '50% auto'
    row 0, 'Click Statistics - Presenter (after)'       , 'code-campaign-05-action-click-statistics-2.rb', 'code-campaign-05-action-click-statistics-2-1.rb', show_slide_title: false, lines: [*(1..29),47], bsize: '45% auto'
    row 0, 'Click Statistics - Presenter (after)'       , 'code-campaign-05-action-click-statistics-2.rb', 'code-campaign-05-action-click-statistics-2-2.rb', show_slide_title: false, lines: [1,2,*(20..47)], bsize: '50% auto'
    row 0, 'Click Statistics - Presenter (after)'       , 'code-campaign-05-action-click-statistics-2.rb', 'code-campaign-05-action-click-statistics-2-3.rb', show_slide_title: false, bsize: '40% auto'
    row 0, 'Click Statistics - Presenter (usage)'       , 'code-campaign-05-action-click-statistics-9.rb', show_slide_title: false
    row 0, 'Contacts - Presenter <br/><a>separated</a> query/present'       , 'code-campaign-05-action-contact-0.rb', bsize: '45% auto'
    row 0, 'Contacts - Query'                           , 'code-campaign-05-action-contact-2.rb'  , show_slide_title: false, bsize: '60% auto'
    row 0, 'Contacts - Presenter (List)'                , 'code-campaign-05-action-contact-2a.rb' , show_slide_title: false
    row 0, 'Contacts - Presenter (Summary)'             , 'code-campaign-05-action-contact-2b.rb' , show_slide_title: false
    row 0, 'Contacts - Presenter (Form)'                , 'code-campaign-05-action-contact-2c.rb' , show_slide_title: false, bsize: '60% auto'
    row 0, 'Contacts - Usage'                           , 'code-campaign-05-action-contact-9.rb'  , show_slide_title: false, bsize: '50% auto'
    row 0, 'Decorators'                                 , 'code-campaign-08-decorator-campaign-0.rb'
    row 0, 'Campaign - Decorator'                       , 'code-campaign-08-decorator-campaign-2.rb', bsize: '70% auto', show_slide_title: false
    row 0, 'Campaign - Usage'                           , 'code-campaign-08-decorator-campaign-9.rb', show_slide_title: false
    row 0, 'Commands'                                   , 'code-campaign-06-action-check-bounce-rate-0.rb', bsize: '55% auto'
    row 0, 'Check Bounce Rate - <a>Command</a>'         , 'code-campaign-06-action-check-bounce-rate-1.rb', bsize: '40% auto'
    row 0, 'Check Bounce Rate - <a>Command</a>'         , 'code-campaign-06-action-check-bounce-rate-1.rb', 'code-campaign-06-action-check-bounce-rate-1a.rb', show_slide_title: false, lines: [1,2,*(3..22), 52]
    row 0, 'Check Bounce Rate - <a>Command</a>'         , 'code-campaign-06-action-check-bounce-rate-1.rb', 'code-campaign-06-action-check-bounce-rate-1b.rb', show_slide_title: false, lines: [1,2,*(22..35), 52]
    row 0, 'Check Bounce Rate - <a>Command</a>'         , 'code-campaign-06-action-check-bounce-rate-1.rb', 'code-campaign-06-action-check-bounce-rate-1c.rb', show_slide_title: false, lines: [1,2,*(37..50), 52]
    row 0, 'Check Bounce Rate - Usage'                  , 'code-campaign-06-action-check-bounce-rate-9.rb', show_slide_title: false
    row 0, 'Async Jobs'                                 , 'code-campaign-07-job-resend-messages-0.rb'
    row 0, 'Resend Messages - <a>Job</a>'               , 'code-campaign-07-job-resend-messages-2.rb' 
    row 0, 'Resend Messages - Usage'                    , 'code-campaign-07-job-resend-messages-9.rb', show_slide_title: false
    # row 0, ' '                                          , 'code-campaign-09.rb'
    # row 0, ' '                                          , 'code-campaign-10.rb'
    # row 0, ' '                                          , 'code-campaign-11.rb'
  end

  table :highlight_css do
    fields %i[active filename url]

    row 2, 'a11y-light.css',               'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/a11y-light.css'
    row 0, 'agate.css',                    'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/agate.css'
    row 0, 'an-old-hope.css',              'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/an-old-hope.css'
    row 0, 'androidstudio.css',            'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/androidstudio.css'
    row 0, 'arduino-light.css',            'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/arduino-light.css'
    row 0, 'arta.css',                     'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/arta.css'
    row 0, 'ascetic.css',                  'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/ascetic.css'
    row 0, 'atom-one-dark-reasonable.css', 'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/atom-one-dark-reasonable.css'
    row 0, 'atom-one-dark.css',            'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/atom-one-dark.css'
    row 2, 'atom-one-light.css',           'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/atom-one-light.css'
    row 0, 'brown-paper.css',              'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/brown-paper.css'
    row 0, 'codepen-embed.css',            'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/codepen-embed.css'
    row 2, 'color-brewer.css',             'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/color-brewer.css'
    row 0, 'dark.css',                     'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/dark.css'
    row 0, 'default.css',                  'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/default.css'
    row 0, 'devibeans.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/devibeans.css'
    row 0, 'docco.css',                    'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/docco.css'
    row 0, 'far.css',                      'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/far.css'
    row 0, 'foundation.css',               'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/foundation.css'
    row 1, 'github-dark-dimmed.css',       'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/github-dark-dimmed.css'
    row 0, 'github-dark.css',              'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/github-dark.css'
    row 0, 'github.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/github.css'
    row 0, 'gml.css',                      'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/gml.css'
    row 0, 'github.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/github.css'
    row 0, 'gml.css',                      'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/gml.css'
    row 0, 'googlecode.css',               'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/googlecode.css'
    row 0, 'gradient-dark.css',            'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/gradient-dark.css'
    row 0, 'gradient-light.css',           'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/gradient-light.css'
    row 0, 'grayscale.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/grayscale.css'
    row 0, 'hybrid.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/hybrid.css'
    row 0, 'idea.css',                     'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/idea.css'
    row 0, 'ir-black.css',                 'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/ir-black.css'
    row 0, 'isbl-editor-dark.css',         'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/isbl-editor-dark.css'
    row 0, 'isbl-editor-light.css',        'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/isbl-editor-light.css'
    row 0, 'kimbie-dark.css',              'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/kimbie-dark.css'
    row 2, 'kimbie-light.css',             'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/kimbie-light.css'
    row 0, 'lightfair.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/lightfair.css'
    row 0, 'lioshi.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/lioshi.css'
    row 0, 'lightfair.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/lightfair.css'
    row 0, 'lioshi.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/lioshi.css'
    row 0, 'magula.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/magula.css'
    row 0, 'mono-blue.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/mono-blue.css'
    row 0, 'monokai-sublime.css',          'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/monokai-sublime.css'
    row 0, 'monokai.css',                  'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/monokai.css'
    row 0, 'night-owl.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/night-owl.css'
    row 0, 'nnfx-dark.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/nnfx-dark.css'
    row 0, 'nnfx-light.css',               'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/nnfx-light.css'
    row 0, 'nord.css',                     'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/nord.css'
    row 0, 'obsidian.css',                 'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/obsidian.css'
    row 0, 'paraiso-dark.css',             'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/paraiso-dark.css'
    row 0, 'paraiso-light.css',            'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/paraiso-light.css'
    row 0, 'pojoaque.css',                 'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/pojoaque.css'
    row 0, 'purebasic.css',                'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/purebasic.css'
    row 0, 'qtcreator-dark.css',           'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/qtcreator-dark.css'
    row 0, 'qtcreator-light.css',          'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/qtcreator-light.css'
    row 0, 'stackoverflow-dark.css',       'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/stackoverflow-dark.css'
    row 0, 'stackoverflow-light.css',      'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/stackoverflow-light.css'
    row 0, 'sunburst.css',                 'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/sunburst.css'
    row 0, 'tomorrow-night-blue.css',      'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/tomorrow-night-blue.css'
    row 0, 'tomorrow-night-bright.css',    'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/tomorrow-night-bright.css'
    row 0, 'vs.css',                       'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/vs.css'
    row 0, 'vs2015.css',                   'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/vs2015.css'
    row 0, 'xcode.css',                    'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/xcode.css'
    row 0, 'xt256.css',                    'https://raw.githubusercontent.com/highlightjs/highlight.js/main/src/styles/xt256.css'
  end

  def pbcopy(input)
    str = input.to_s
    IO.popen('pbcopy', 'w') { |f| f << str }
    str
   end
   
   def pbpaste
    `pbpaste`
   end
end
