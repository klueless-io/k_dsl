# ------------------------------------------------------------
# Slide Deck Video
# ------------------------------------------------------------

KDsl.microapp :change_journal_tim_jaudszims do
  settings do
    app_path      '~/dev/kgems/k_dsl/_projects/idea_video/gratitude_bridge/change_journal_tim_jaudszims'
    data_path     '_/.data'
  end

  def on_action
    # write_json is_edit: true
  end
end
