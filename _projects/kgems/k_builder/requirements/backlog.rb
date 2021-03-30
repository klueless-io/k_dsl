# Backlog of items to be addressed
# ------------------------------------------------------------
# /Users/davidcruwys/dev/kgems/k_dsl/_/.definition/ruby-gem/backlog.rb
# /Users/davidcruwys/dev/kgems/k_dsl/_/.definition/ruby-gem/requirements/backlog.rb
# /Users/davidcruwys/dev/kgems/rspec-usecases/_/def-ruby-gem/requirements/backlog.rb
KDsl.document :backlog do
  def on_action
    # Build a story entry from a list of tasks
    x = data_struct
    x.tasks = x.backlog.rows.select { |r| r.type == 'task' && r.status.start_with?('x') }
    
    # write_clipboard custom_data: x, template: <<~TEXT
    #   row :story, :current, 'As a Developer, I can, so that',
    #     [
    #       
    #     ]
    # TEXT

    # write_json custom_data: x, is_edit: true
  end

  table :backlog do
    # type: :story, :task
    # status: :done, :current, :backlog
    fields [f(:type, :story), f(:status, :todo), :story, :tasks]
    
    row :task, :backlog, 'WatchBuilder - Build Watcher (as a builder)'
    row :task, :backlog, 'BaseBuilder'
    row :task, :backlog, 'AppBuilder'
    row :task, :backlog, 'WebBuilder'
    row :task, :backlog, '- PackageBuilder'
    row :task, :backlog, '- Webpack5Builder'
    row :task, :backlog, '- ReactBuilder'
    row :task, :backlog, '- SlideDeckBuilder'
    row :task, :backlog, '- JavascriptBuilder'
    row :task, :backlog, 'SolutionBuilder'
    row :task, :backlog, 'DotnetBuilder'
    row :task, :backlog, '- C#Console'
    row :task, :backlog, '- C#Mvc'
    row :task, :backlog, 'RubyBuilder'
    row :task, :backlog, '- RubyGem'
    row :task, :backlog, '- RailsApp'
    row :task, :backlog, 'PythonBuilder'
    row :task, :backlog, 'DddBuilder'
    row :task, :backlog, '- DddGenerator'
  end
end
