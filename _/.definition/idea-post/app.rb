# ------------------------------------------------------------
# Idea for a Blog Post
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  s = settings do
    name                          parent.key
    app_type                      'idea-blog-post'
    post_type                     '{{settings.post_type}}'
    description                   '[{{titleize name}}] is a {{titleize settings.post_type}} article that will be written for the {{titleize settings.target_website}} website'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/{{settings.website_slug}}/{{snake name}}'
    source                        '{{settings.source}}'
    publish_on                    ['dev.to', 'quora', 'reddit', 'buzzfeed']
    title                         '{{titleize name}}'
    app_path                      '~/dev/{{settings.project_group}}/{{snake name}}'
    data_path                     '_/.data'
  end

  # Screenshots

  table 'someimage.png' do
    fields %i[bullet_point section description]

    # row 1, 'text'                   , 'input area that will take text that needs to be written' 
    # row 2, 'generate_voiceover'     , 'Click this button to generate a voice over' 
    # row 3, 'id'                     , 'Voice over ID can be used for selection purposes for (delete or download)' 
    # row 4, 'delete'                 , 'Click this button to delete the selected voice over' 
    # row 5, 'download'               , 'Click this button to download the voiceover' 
  end

  # Commands

  table :listicle do
    fields %i[name url description]

    # row 'name'   url: ''
  end

  actions do
  end

end
