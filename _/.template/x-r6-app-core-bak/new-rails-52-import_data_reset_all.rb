module ImportDataResetAll

  def reset_all

    settings = open_settings()

    {{#each models}}
      # Delete data for {{titleize (humanize this.names)}}
      if settings['{{snake this.name}}'] && settings['{{snake this.name}}']['can_reset']
        L.kv'Delete', '{{camelU this.name}}'
        {{camelU this.name}}.delete_all
        PgUtil.execute_sql("alter sequence {{snake this.names}}_id_seq restart with 1;")
      end

{{/each}}
  end

end
