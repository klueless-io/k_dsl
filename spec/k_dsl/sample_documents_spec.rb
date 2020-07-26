# # frozen_string_literal: true

# require 'spec_helper'

# RSpec.describe 'DSL Sample Documents' do
#   # rubocop:disable all
#   describe '#simple document' do
#     let(:document) do
#       KDsl::Model::Document.new(:simple) do
#         settings do
#           field1 'Some Text'
#           field2 999
#           field3 true
#         end
#         table do
#           fields [:name, f(:age, 30, 'Integer'), f(:manager, false, 'Boolean')]

#           row 'David', 48, true
#           row 'Alison'
#           row 'Bob', manager: true
#         end
#       end
#     end

#     # it { puts JSON.pretty_generate document.data }
#   end

#   describe '#multiple setting groups' do
#     let(:document) do
#       KDsl::Model::Document.new(:simple) do
#         settings do
#           field1 'Some Text'
#           field2 999
#           field3 true
#         end
#         settings :more_settings do
#           field1 'Some Other Text'
#         end
#       end
#     end

#     # it { puts JSON.pretty_generate document.data }
#   end

#   describe '#simple document' do
#     let(:document) do
#       KDsl::Model::Document.new(:simple) do
#         table do
#           fields [:name, f(:age, 30, 'Integer'), f(:manager, false, 'Boolean')]

#           row 'David', 48, true
#           row 'Alison'
#           row 'Bob', manager: true
#         end
#       end
#     end

#     it { puts JSON.pretty_generate document.data }
#   end

#   describe 'Image Copy & Place' do
#     Klue.screenshot.copy_and_place do
#       settings do
#         actions               :write
#         active_listener       true
#         project               'answer_the_public'
#         filename              'clip-[nnn]'         
#         image_format          'jpeg'
#         output_folder         '~/projects/#{project}/images'
#       end

#       actions do
#         listen_to_clipboard if active_listener

#         if action_write
#           write_image         
#           open_in :finder, :once
#         end

#         reorder_images if action_reorder       
#       end

#     end

#     Klue.marketing.scratchpad do
#       settings do
#         what                    'Image Copy & Place'
#         why                     'When tacking screenshots or copying files, it would be nice to have the files save automatically into a categorised location'
#         idea_date               'Sunday, 19 July 2020'
#         idea_video              'https://youtu.be/E4RLCKenxCs'
#         idea_video_title        'Image Copy & Place'
#         idea_video_description  "As a content creator, I should be able to screen shot images and automatically save them to specific project folder with, so that I can quickly build content"
#       end

#       taglines do
#         tagline           'How to automatically save images and screenshots into the appropriate location on your computer'
#       end

#       stories do
#         story 'As a content creator, I should be able to screen shot images and automatically save them to specific project folder with, so that I can quickly build content'
#       end
#     end
#   end

#   describe 'Answer the public (style) search engine' do
#     Klue.search.graph do

#       settings do
#         search                    'Personal Trainer'
#         search_location           'en_au'
#       end

#       actions do
#         search
#         write_graphs style: :answer_the_public
#       end

#     end

#     Klue.marketing.scratchpad do
#       settings do
#         what                    'Build an Answer the public (style) of search engine'
#         why                     'To simplify marketing research'
#         problem                 'A'
#         idea_date               'Sunday, 19 July 2020'
#         idea_video              'https://youtu.be/WqRjSmMYlQM'
#         idea_video_title        'Answer the public (style) search engine'
#         idea_video_description  "Here is an idea for a natural language tool that emulates the 'Answer the Public' search engine, which is useful for doing SEO research.

# #answerthepublic"
#       end

#       taglines do
#         tagline           'How I built a better "Answer the Public"'
#         tagline           'Better than "Answer the Public", how I built "Klue the Public"'
#       end

#       issues do
#         issue             'Answer the public is expansive'
#         issue             'You need to be able to search sites like google using a VPN if you want to find results in another country'
#       end
#     end
#   end

#   describe 'Automate Descriptions for Topic Resource Videos' do
#     Klue.microapp :topic_resource_video do

#       settings do
#         title                 'Beginners Guide to Roam Reasearch'
#         input_audio           'https://aws-s3/path-to-audio-file'
#       end

#       table do
#         fields [:title, :time_code, :link]

#         row 'Fact File'                   , 0.37
#         row 'Roam research new pricing'   , 1.20
#         row 'How Roam Works'              , 1.40
#         row 'CSS in Roam'                 , 3.49, 'http://youtube/xxxx'
#       end

#       actions do
#         build_timeline
#         add_call_to_action
#       end

#     end

#     Klue.marketing.scratchpad do
#       settings do
#         what              'Timeline that goes into YouTube descriptions to tell people where to find information'
#         why               'Help people find exactly what they want'
#         idea_date         'Thursday, 16 July 2020'
#         idea_video        'https://youtu.be/M8BNHCKd42A'
#         idea_video_title  'Automate descriptions for curated topic videos'
#       end

#       taglines do
#         tagline           'How to increase engagment and professionalism with your YouTube videos'
#         tagline           'How to improve video SEO'
#       end
#     end
#   end

#   describe 'Automate background soundtrack for video intros' do
#     Klue.video.soundtrack :create_video_intro do
#       settings do
#         soundtrack            'soft-background-soundtrack.mp3'
#         fade_in               0.3
#         fade_out              0.3
#         input_video           '~/somepath/previously-generated-intro-video.mp4'
#         output_video          '~/somepath/intro-video-with-sound.mp4'
#       end

#       actions do
#         merge_soundtrack soundtrack: settings.soundtrack,
#                          input_video: settings.input_video,
#                          output_video: settings.output_video
#       end
#     end

#     Klue.marketing.scratchpad do
#       settings do
#         what              'Animated Intro Videos should have an engaging background sound clip.'
#         why               'Creates consistency and harmony for the person following the tutorial'
#         notes             'I have heard this background sound before on udemy courses and it is quite professional'
#         idea_date         'Thursday, 19 July 2020'
#         idea_video        'https://youtu.be/9kl5W2F0VYY'
#         idea_video_title  "Automate background soundtrack for video intros"
#       end

#       taglines do
#         tagline           ''
#       end

#       stories do
#         story 'As a tutorial creator, when I create short video clips that start with a title, I should have an engaging background audio clip'
#       end
#     end
#   end

#   describe 'Generate Animated Video Intros' do
#     Klue.video.animated_intro :create_video_intro do

#       s = settings do
#         title                 'How I organize my day'
#         template              :green_square
#       end

#       actions do
#         generate_video s.title.snakecase, :mp4
#       end
#     end

#     Klue.marketing.scratchpad do
#       settings do
#         what              'Timeline that goes into YouTube descriptions to tell people where to find information'
#         why               'Help people find exactly what they want'
#         idea_date         'Thursday, 16 July 2020'
#         idea_video        'https://youtu.be/Vk1692C8wDs'
#         idea_video_title  "Generate Animated Video Intro's"
#       end

#       taglines do
#         tagline           'How to quickly generate a video intro for a specific title'
#         tagline           'Automated animated video intros for specific titles'
#         tagline           'Build a an animated intro title in under a minute'
#       end
#     end
#   end

#   describe 'Roam Research - Generate Tables' do
#     Klue.roam.table :habits do

#       todo = '{{[[TODO]]}}'
#       skip = ''

#       table do
#         columns ['Habit', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

#         row 'Gratitude Bridge (Step 11)'  , todo, todo, todo, todo, todo, skip, todo
#         row 'Healthy Breakfast'           , todo, todo, todo, todo, todo, skip, todo
#         row 'Step 10'                     , todo, todo, todo, todo, todo, skip, todo
#         row 'Good Lunch'                  , todo, todo, todo, todo, todo, skip, todo
#         row 'Healthy Dinner'              , todo, todo, todo, todo, todo, skip, todo
#         row 'Make Bed'                    , todo, todo, todo, todo, todo, skip, todo
#       end

#       actions do
#         copy_to_clipboard
#       end
#     end

#     Klue.template.sample do
#       <<-TEMPLATE
#       - {{[[table]]}}
#         - **Habit**
#             - Monday
#                 - Tuesday
#                     - Wedneday
#                         - Thursday
#                             - Fridayﬁ
#                                 - Saturday
#                                     - Sunday
#         - Gratitude Bridge (Step 11 in the Morning)
#             - {{[[TODO]]}} 
#                 - {{[[TODO]]}} 
#                     - {{[[TODO]]}} 
#                         - {{[[TODO]]}} 
#                             - {{[[TODO]]}} 
#                                 - {{[[TODO]]}} 
#                                     - {{[[TODO]]}} 
#         - Eat Decent Breakfast
#             - {{[[TODO]]}} 
#                 - {{[[TODO]]}} 
#                     - {{[[TODO]]}} 
#                         - {{[[TODO]]}} 
#                             - {{[[TODO]]}} 
#                                 - {{[[TODO]]}} 
#                                     - {{[[TODO]]}} 
#         - Step 10
#             - {{[[TODO]]}} 
#                 - {{[[TODO]]}} 
#                     - {{[[TODO]]}} 
#                         - {{[[TODO]]}} 
#                             - {{[[TODO]]}} 
#                                 - {{[[TODO]]}} 
#                                     - {{[[TODO]]}} 
#         - Good Lunch
#             - {{[[TODO]]}} 
#                 - {{[[TODO]]}} 
#                     - {{[[TODO]]}} 
#                         - {{[[TODO]]}} 
#                             - {{[[TODO]]}} 
#                                 - {{[[TODO]]}} 
#                                     - {{[[TODO]]}} 
#         - Healthy Dinner
#             - {{[[TODO]]}} 
#                 - {{[[TODO]]}} 
#                     - {{[[TODO]]}} 
#                         - {{[[TODO]]}} 
#                             - {{[[TODO]]}} 
#                                 - {{[[TODO]]}} 
#                                     - {{[[TODO]]}} 
#         - 
#             - {{[[TODO]]}} 
#                 - {{[[TODO]]}} 
#                     - {{[[TODO]]}} 
#                         - {{[[TODO]]}} 
#                             - {{[[TODO]]}} 
#                                 - {{[[TODO]]}} 
#                                     - {{[[TODO]]}} 

#       TEMPLATE
#     end
#   end
#   # rubocop:enable all
# end
