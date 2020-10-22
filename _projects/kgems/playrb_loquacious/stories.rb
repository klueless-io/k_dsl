# ------------------------------------------------------------
# Ruby Commandlet Stories
# ------------------------------------------------------------

KDsl.document :stories do
  s = settings do
    main_story                    'As a Developer, I want to understand what the Loquacious GEM is doing via example, so that I improve my skills with Ruby'
  end

  actions do
    # write_json is_edit: true
  end

  table :stories do
    fields [:story, :tasks, f(:active, true)]

    row s.main_story,
        [
          'Create new gem', 
          'Setup deployment pipeline',
          'Setup guard and unit tests'
        ]

    row 'As a Developer, I should be able to , so that I',
        []

    # row 'As a Developer, I should be able to , so that I',
    #     []
  end

end
