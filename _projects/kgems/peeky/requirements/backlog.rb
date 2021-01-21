# ------------------------------------------------------------
# Ruby Commandlet Features
# ------------------------------------------------------------

KDsl.document :backlog do
  def on_action
    # Build a story entry from a list of tasks
    x = data_struct
    x.tasks = x.stories.rows.select { |r| r.type == 'task' && r.status.start_with?('x') }
    
    # write_clipboard custom_data: x, template: <<~TEXT
    #   row :story, :current, 'As a Developer, I can, so that',
    #     [
    #       {{#each tasks}}
    #       '{{story}}'{{#if @last}}{{else}},{{/if}}
    #       {{/each}}
    #     ]
    # TEXT

    # write_json custom_data: x, is_edit: true
  end

  table :stories do
    # type: :story, :task
    # status: :done, :current, :backlog
    fields [f(:type, :story), f(:status, :todo), :story, :tasks]
    
    row :task, :backlog, 'Add support natural source code order to accessors, readers, writers and methods'
    row :task, :backlog, 'Document usage using the klue-usage GEM'
    row :task, :backlog, 'Add YARD documentation support to Guard or as a live server'
    row :task, :backlog, 'Add initialize method to class renderers'
    row :task, :backlog, 'Add support for opts to class renderers'
    row :task, :backlog, 'Refactor method to class renderers so that they have a base class'
    row :task, :backlog, 'Add GitHub sponsorship to readme file',
      [
        'https://docs.github.com/en/free-pro-team@latest/github/supporting-the-open-source-community-with-github-sponsors/receiving-sponsorships-through-github-sponsors',
        'funding.yml',
        'example: https://github.com/0xGG/crossnote/commit/d2a3feea1ac0f8d1a7c91b350eb34f9899af7662'
      ]
    row :task, :backlog, 'Back compare templates vis definitions	'
    row :task, :backlog, 'Auto create .template folder with copied definitions'
    row :task, :backlog, 'Move sample classes to factory girl'

    row :story, :backlog, 'As a Developer, I can , So that'
  end

end

row :story, :current, 'As a Developer, I can, so that',
  [
    'Add support default parameters'
  ]
