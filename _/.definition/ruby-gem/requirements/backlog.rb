# Backlog of items to be addressed
# ------------------------------------------------------------

KDsl.document :backlog do
  def on_action
    # Build a story entry from a list of tasks
    x = data_struct
    x.tasks = x.backlog.rows.select { |r| r.type == 'task' && r.status.start_with?('x') }
    
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

  table :backlog do
    # type: :story, :task
    # status: :done, :current, :backlog
    fields [f(:type, :story), f(:status, :todo), :story, :tasks]
    
    row :task, :backlog, ''
  end
end
