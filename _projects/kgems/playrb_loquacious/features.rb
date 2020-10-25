# ------------------------------------------------------------
# Ruby Commandlet Features
# ------------------------------------------------------------

KDsl.document :features do
  s = settings do
    gem_features_title              'Loquacious Features'
    gem_features_description        'Descriptive configuration files for Ruby written in Ruby. <br /><br />Loquacious provides a very open configuration system written in ruby and descriptions for each configuration attribute. The attributes and descriptions can be iterated over allowing for helpful information about those attributes to be displayed to the user.'

    klueless_features_title         'KlueLess Template Features'
    klueless_features_description   'This KlueLess ruby GEM .template provides the following features'
  end

  t = <<~HTML
    <html>
    <body>
      <h1>{{settings.gem_features_title}}</h1>
      <p>{{safe settings.gem_features_description}}</p>

      <table>
      <thead>
      <tr>
        {{#each gem_features.fields}}
          <th>{{this.name}}</th>
        {{/each}}
      </tr>
      </thead>
      <tbody>
        {{#each gem_features.rows}}
        <tr>
        <td>{{this.group}}</td>
        <td>{{this.section}}</td>
        <td>{{this.title}}</td>
        <td>{{this.description}}</td>
        </tr>
        {{/each}}
      </tbody>
      </table>

      <hr>
      <h2>{{settings.klueless_features_title}}</h2>
      <p>{{settings.klueless_features_description}}</p>

      <table>
      <thead>
      <tr>
        {{#each klueless_features.fields}}
          <th>{{this.name}}</th>
        {{/each}}
      </tr>
      </thead>
      <tbody>
        {{#each klueless_features.rows}}
        <tr>
        <td>{{this.group}}</td>
        <td>{{this.section}}</td>
        <td>{{this.title}}</td>
        <td>{{this.description}}</td>
        </tr>
        {{/each}}
      </tbody>
      </table>
    </body>
    </html>
  HTML

  def on_action
    # write_json is_edit: true
    write_html with_meta: true, is_edit: false, template: t, output_file: '/Users/davidcruwys/dev/kgems/playrb_loquacious/README-features.html'
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
