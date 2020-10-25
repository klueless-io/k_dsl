# ------------------------------------------------------------
# Ruby Commandlet Stories
# ------------------------------------------------------------

KDsl.document :stories do
  s = settings do
    main_story                    'As a Developer, I want to understand what the Loquacious GEM is doing via example, so that I improve my skills with Ruby'
  end

  t = <<~HTML
    <html>
    <body>
    <h2>Stories</h2>

    <h2>Main Story</h2>
    <p>{{settings.main_story}}</p>

    <h3>All Stories</h3>

    {{#each stories.rows}}
      <h4>{{this.story}}</h4>
      <ul>
      {{#each this.tasks}}
        <li>{{this}}</li>
      {{/each}}
      </ul>
    {{/each}}

    </tbody>
    </table>
    </body>
    </html>
  HTML

  def on_action
    # write_json is_edit: true
    write_html with_meta: true, is_edit: false, template: t, output_file: '/Users/davidcruwys/dev/kgems/playrb_loquacious/README-stories.html'
  end

  table :stories do
    fields [:story, :tasks, f(:active, true)]

    row 'Setup the Loquacious GEM',
        [
          'Create new gem', 
          'Setup deployment pipeline',
          'Setup Rspec unit tests',
          'Setup Rubocop',
          'Watch Rspec and Rubocop using Guard'
        ]

    # row 'As a Developer, I should be able to , so that I',
    #     []
  end

end
