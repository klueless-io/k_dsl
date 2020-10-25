# ------------------------------------------------------------
# Ruby Commandlet Features
# ------------------------------------------------------------

KDsl.document :{{snake name}} do
  s = settings do
  end

  def on_action
    # write_json is_edit: true
  end

  table :features do
    fields [:story, :tasks, f(:active, true)]

    # row 'As a {{settings.avatar}}, I should be able to , so that I',
    #     []
  end

  table :klueless_features do
    fields [:story, :tasks, f(:active, true)]

    # row 'As a {{settings.avatar}}, I should be able to , so that I',
    #     []
  end

end
