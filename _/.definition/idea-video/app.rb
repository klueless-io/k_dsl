# ------------------------------------------------------------
# Slide Deck Video
# ------------------------------------------------------------

KDsl.microapp :{{snake name}} do
  settings do
    app_path      '~/dev/kgems/k_dsl/_projects/idea_video/{{snake settings.target_website}}/{{snake settings.name}}'
    data_path     '_/.data'
  end

  def on_action
    # write_json is_edit: true
  end
end
