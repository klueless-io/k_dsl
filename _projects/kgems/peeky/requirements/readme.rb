# ------------------------------------------------------------
# Ruby Commandlet Stories
# ------------------------------------------------------------

KDsl.blueprint :readme do
  settings do
    template_rel_path   'ruby-gem'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'open')]

    row 'README.md'
    row 'STORIES.md'
    row 'USAGE.md'
  end

  def on_action
    microapp = import(:peeky, :microapp)
    story_rows = import(:stories).stories.rows
    # backlog_rows = import(:backlog).stories.rows
    usage_example_group_rows = import(:usage).example_groups.rows
    usage_example_rows = import(:usage).examples.rows

    stories = story_rows.select { |row| row.type == 'story' }
    stories_done = stories.select { |row| row.status == 'done' }
    stories_featured = stories_done.select { |row| row.featured_position.to_i > 0 }.sort { |row| row.featured_position }
    stories_current = stories.select { |row| row.status == 'current' }
    tasks = story_rows.select { |row| row.type == 'task' }
    tasks_done = tasks.select { |row| row.status == 'done' }
    tasks_current = tasks.select { |row| row.status == 'current' }

    # Build Usage

    groups = usage_example_group_rows.map do |group|
      examples = usage_example_rows.select { |example| group.key == example.group_key }
                                   .map    { |example| example.to_h.except(:group_key) } 

      {
        **group.to_h.except(:key),
        examples: examples
      }
    end

    groups_detailed = groups.select { |g| g[:featured] == false }
    groups_featured = groups.select { |g| g[:featured] == true }

    usage = OpenStruct.new(groups_detailed: groups_detailed, groups_featured: groups_featured).to_h
    # write_json(is_edit: true, custom_data: usage)

    # write_json is_edit: true
    # write_json(is_edit: true, custom_data: usage)
    run_blueprint microapp: microapp,
                  main_story: microapp.settings.main_story,
                  stories: stories,
                  featured_stories: stories_featured,
                  stories_done: stories_done,
                  stories_current: stories_current,
                  tasks: tasks,
                  tasks_done: tasks_done,
                  tasks_current: tasks_current,
                  usage: usage

  end
end
