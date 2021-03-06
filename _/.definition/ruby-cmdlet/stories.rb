# ------------------------------------------------------------
# Ruby Commandlet Stories
# ------------------------------------------------------------

KDsl.stories :{{snake name}} do
  s = settings do
    main_story                    '{{settings.main_story}}'
  end

  def on_action
    write_json is_edit: true
  end

  table :stories do
    fields [:story, :tasks, f(:active, true)]

    row s.main_story,
        [
          'Create new command line tool', 
          'Setup deployment pipeline',
          'Setup guard and unit tests'
        ]

    row 'As a XX, I should be able to , so that I',
        []

    # row 'As a Developer, I should be able to , so that I',
    #     []

    # row 'As a Developer, I should be able to , so that I',
    #     []

    # row 'As a Developer, I should be able to , so that I',
    #     []
  end

end
