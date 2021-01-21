# ------------------------------------------------------------
# MicroApp: Ruby GEM
# ------------------------------------------------------------

KDsl.microapp :thought do
  settings do
    app_path '~/dev/kgems/k_dsl/_projects/idea_video/appy_dave/how_i_planned_for_my_new_ruby_gem_handlebars_helpers'
  end

  def on_action
    write_json is_edit: true
  end
end
