# ------------------------------------------------------------
# Code Idea
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  s = settings do
    name                          parent.key
    app_type                      'Idea'
    new_app_type                  '{{new_app_type}}'
    description                   '{{titleize name}} is an idea for'
    application                   '{{snake name}}'
    author                        'David'
    author_email                  'david@ideasmen.com.au'
    shortcut                      '{{snake name}}'
    website                       'http://appydave.com/{{settings.website_slug}}/{{snake name}}'
    affiliate_link                ''
    main_story                    'As a Developer, I should be able to , so that I'
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

  table :commands do
    fields %i[command description]

    # row 'text_to_speech'          , 'Update text_input, click generate_voice_over'
    # row 'get_voice_over_id'       , 'Called after text_to_speech, this will get the latest ID: 2341922'
    # row 'play_voice_over'         , 'Given a voice_over_id, this will play the voiceover'
    # row 'download_voice_over'     , 'Given a voice_over_id, this will download the file'
    # row 'copy_voice_over'         , 'Given a voice_over_id, this will copy the download file to a target location'
    # row 'delete_voice_over'       , 'Given a voice_over_id, this will delete the generated voice'
  end

  actions do
  end

end
