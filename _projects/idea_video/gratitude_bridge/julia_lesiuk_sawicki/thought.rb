# ------------------------------------------------------------
# Idea for a new 'Listicle' style blog video
# ------------------------------------------------------------
KDsl.blueprint :julia_lesiuk_sawicki do
  settings do
    name                          parent.key
    video_type                    'thought'
    keyword                       'trauma'
    title                         'Julia Lesiuk Sawicki'
    target_website                'gratitude_bridge'
    description                   ''
    author                        'AppyDave'
    author_email                  'david@ideasmen.com.au'
    website                       'http://appydave.com/video/julia-lesiuk-sawicki'
    publish_on                    []
    app_path                      '~/dev/kgems/k_dsl/_projects/idea_video/gratitude_bridge/julia_lesiuk_sawicki'

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

    L.info File.exist?(file)
    content = File.read(file)
    timeline = JSON.parse(content)[1..10]
    timeline.each do |tl|
      date_time = DateTime.strptime("2017/#{tl['date']} #{tl['time']}", "%Y/%m/%d %H:%M" )
      tl[:date_nice] = date_time.strftime("#{ordinalize(date_time.day)} %b") 
      tl[:time_nice] = date_time.strftime("%H/%M") 
    end

    template_file = File.join(path, 'timeline-template.html')
    output_file = File.join(path, 'jc.html')

    write_html(is_edit: true,
               custom_data: { timeline: timeline },
               template_file: template_file,
               output_file: output_file)

    L.warn '-' * 100

    # write_html 
    # write_json is_edit: true
  end

  def ordinalize(number)
    if (11..13).include?(number.to_i.abs % 100)
      "#{number}th"
    else
      case number.to_i.abs % 10
        when 1; "#{number}st"
        when 2; "#{number}nd"
        when 3; "#{number}rd"
        else    "#{number}th"
      end
    end
  end

end
