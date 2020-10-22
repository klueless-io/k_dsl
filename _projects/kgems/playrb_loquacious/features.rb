# ------------------------------------------------------------
# Ruby Commandlet Features
# ------------------------------------------------------------

KDsl.document :features do
  s = settings do
    klueless_features_title         'KlueLess Features'
    klueless_features_description   'The KlueLess ruby GEM .template provides the following features'
  end

  actions do
    write_json is_edit: true
    # write
  end

  table :features do
    fields [:story, :tasks, f(:active, true)]

    # row 'As a Developer, I should be able to , so that I',
    #     []
  end

  table :klueless_features do
    fields [:group, :section, :title, :description]

    row 'code'       ,      'upgrade', 'version', 'Uses semantic version number'
    
    row 'testing'    ,      'unit-testing'  , 'rspec', 'RSpec is configured'
    row 'testing'    ,      'code-coverage' , 'rubocop', 'Rubocop is configured with opinionated rules'

    row 'development',      'extension'   , 'guard', 'Guard is configured for development'
    row 'development',      'extension'   , 'guard-rspec' , 'Guard is watching for code changes and running rspec automatically'
    row 'development',      'extension'   , 'guard-cop'   , 'Rubocop is watching for code changes and checking code quality after green test pass'

    row 'development',      'command line', 'kgitsync'    , 'Easily synchronize Dev & Master branches'
    row 'development',      'command line', 'khotfix'     , 'Easily create a new versioned hotfix against master branch'

    row 'development',      'hooks'       , 'pre-commit'  , 'Prevent debugging code from being deployed to git branch'
    row 'development',      'hooks'       , 'update-version', 'Update the semantic version number in code, used by khotfix'

  end
end
