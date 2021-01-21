# ------------------------------------------------------------
# Backlog of items to be addressed
# ------------------------------------------------------------

KDsl.document :backlog do
  def on_action
    # Build a story entry from a list of tasks
    x = data_struct
    x.tasks = x.backlog.rows.select { |r| r.type == 'task' && r.status.start_with?('x') }
    
    write_clipboard custom_data: x, template: <<~TEXT
      row :story, :current, 'As a Developer, I can, so that',
        [
          {{#each tasks}}
          '{{story}}'{{#if @last}}{{else}},{{/if}}
          {{/each}}
        ]
    TEXT

    # write_json custom_data: x, is_edit: true
  end

  # type: :story, :task
  # status: :done, :current, :backlog

  table :backlog do
    fields [f(:type, :story), f(:status, :todo), :story, :tasks]
    
    row :task, :backlog, 'Make a list of potential helpers and categorize'
    row :task, :backlog, 'Download from GitHub and classify the existing JS code', [
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/array.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/array.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/code.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/code.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/collection.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/collection.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/comparison.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/comparison.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/date.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/date.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/fs.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/fs.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/html.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/html.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/i18n.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/i18n.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/inflection.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/inflection.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/logging.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/logging.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/markdown.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/markdown.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/match.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/match.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/math.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/math.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/misc.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/misc.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/number.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/number.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/object.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/object.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/path.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/path.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/regex.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/regex.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/string.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/string.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/lib/url.js',
      'https://github.com/helpers/handlebars-helpers/blob/master/test/url.js'
    ]
    row :task, :xbacklog, 'Build simplified API for rendering templates'
    row :task, :backlog, 'String templates: Investigate existing string handlers'
  end
end
