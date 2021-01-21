KDsl.document :idea_video do
  settings do
    
    # name                    :julia_lesiuk_sawicki
    # keyword                 :trauma
    # target_website          :gratitude_bridge
    # definition_subfolder    'idea-video'
    # project_group           :idea_video
    # website_slug            :video
    # video_type              :thought
    # video_theme             :gratitude_bridge

    name                    'Change journal, Tim Jaudszims'
    keyword                 :change_journal
    target_website          :gratitude_bridge
    definition_subfolder    'idea-video'
    project_group           :idea_video
    website_slug            :video
    author                  :gratitude_bridge
    video_type              :thought
    video_theme             :gratitude_bridge

    # name                    'How I planned for my new Ruby Gem. Handlebars-Helpers'
    # keyword                 :ruby_gem
    # target_website          :appy_dave
    # definition_subfolder    'idea-video'
    # project_group           :idea_video
    # website_slug            :video
    # video_type              :thought
    # video_theme             :appy_dave
  end

  def on_action
    s = d.settings
    output_folder = "#{f.snake s.project_group}/#{f.snake s.target_website}/#{f.snake s.name}"

    # new_microapp s.name,
    #   definition_subfolder: s.definition_subfolder,
    #   output_subfolder: output_folder,
    #   show_editor: false,
    #   f: true,
    #   debug_only: false

    # file = new_blueprint s.video_type,
    #   definition_subfolder: s.definition_subfolder,
    #   output_subfolder: output_folder,
    #   show_editor: true,
    #   f: true,
    #   debug_only: false

    new_archetype :video_deck, :model,
      definition_name: 'video-deck',
      definition_subfolder: s.definition_subfolder,
      output_subfolder: output_folder,
      f: true

    # new_archetype :video_deck, :model,
    #   definition_subfolder: s.definition_subfolder,
    #   output_subfolder: output_folder,
    #   f: true
    # system("code #{File.dirname(file)}")

    # write_json is_edit: true
  end
end
