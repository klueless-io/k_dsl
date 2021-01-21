# ------------------------------------------------------------
# Idea for a new 'Listicle' style blog video
# ------------------------------------------------------------
KDsl.blueprint :julia_lesiuk_sawiki do
  settings do
    name                          parent.key
    video_type                    'thought'
    keyword                       'trauma'
    title                         'Julia Lesiuk Sawiki'
    target_website                'gratitude_bridge'
    description                   ''
    author                        'AppyDave'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/video/julia-lesiuk-sawiki'
    publish_on                    []
    # app_path                      '~/dev/idea_video/julia_lesiuk_sawiki'
    app_path                      '~/dev/kgems/k_dsl/_projects/idea_video/gratitude_bridge/julia_lesiuk_sawiki'

    data_path                     '_/.data'
  end

  table :structure do
    fields %i[title points aka]

    row 'What Are Traumas?'
    row 'Why Do Traumas Work So Well?', points: []
    row 'Best Practices', points: [], aka: '7 Tips for Writing a Great trauma'
    row 'What Not to Do', points: []
    row 'Conclusion', aka: 'Wrapping Up'
  end

  def on_action
    path = File.expand_path(d.settings.app_path)
    file = File.join(path, 'jc.json')
    # L.warn d.settings.app_path
    # L.warn path
    # L.warn file
    # L.warn File.exist?(file)
    # L.warn File.basename(file)

    timeline = JSON.parse(File.read(file))

    puts 'david'

    # write_html 
    # write_json is_edit: true
  end
end
