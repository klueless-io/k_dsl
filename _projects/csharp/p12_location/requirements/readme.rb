# Build README.MD
# ------------------------------------------------------------

KDsl.blueprint :readme do
  settings do
    template_rel_path   'ruby-gem'
  end

  instructions do
    fields [:template_name, f(:output, '$TEMPLATE_NAME$'), f(:command, 'generate'), f(:active, true), f(:conflict, 'overwrite'), f(:after_write, 'prettier,open')]

    row 'README.md'
    row 'STORIES.md'
    row 'USAGE.md'
  end

  def stories(rows)
    all = rows.select { |row| row.type == 'story' }
    done = all.select { |row| row.status == 'done' }
    current = all.select { |row| row.status == 'current' }
    featured = done.select { |row| row.featured_position.to_i > 0 }
                   .sort { |row, _| row.featured_position }

    OpenStruct.new(all: all, done: done, current: current, feature: featured)
  end

  def tasks(rows)
    all = rows.select { |row| row.type == 'task' }
    done = all.select { |row| row.status == 'done' }
    current = all.select { |row| row.status == 'current' }

    OpenStruct.new(all: all, done: done, current: current)
  end

  def usage
    group_rows = import(:usage).example_groups.rows
    example_rows = import(:usage).examples.rows
    # Build Usage
    all = group_rows.map do |group|
      examples = example_rows.select { |example| group.key == example.group_key }
                             .map    { |example| example.to_h.except(:group_key) } 

      {
        **group.to_h.except(:key),
        examples: examples
      }
    end

    detailed = all.select { |g| g[:featured] == false }
    featured = all.select { |g| g[:featured] == true }

    OpenStruct.new(all: all, detailed: detailed, featured: featured)#.to_h
  end

  def on_action
    # Imports
    microapp = import(:p12_location, :microapp)
    story_rows = import(:stories).stories.rows

    # write_json is_edit: true
    # write_json(is_edit: true, custom_data: stories(story_rows))
    # write_json(is_edit: true, custom_data: tasks(story_rows))
    # write_json(is_edit: true, custom_data: usage)

    run_blueprint microapp: microapp,
                  main_story: microapp.settings.main_story,
                  stories: stories(story_rows),
                  tasks: tasks(story_rows),
                  usage: usage
  end
end
