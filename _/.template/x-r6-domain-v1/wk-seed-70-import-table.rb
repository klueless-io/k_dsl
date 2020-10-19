module ImportTable

  # ----------------------------------------------------------------------
  # Import {{titleize (humanize settings.Models)}}
  # ----------------------------------------------------------------------

  def import_{{snake settings.Model}}(rows)

    rows.each do |row|

      # {{snake settings.Model}} = {{camelU settings.Model}}.find_by_{{snake settings.MainKey}}(row['{{snake settings.MainKey}}'])
      {{snake settings.Model}} = {{camelU settings.Model}}
              .where({{snake settings.MainKey}}: row['{{snake settings.MainKey}}'])
      {{#each relations_one_to_one}}
              .joins(:{{snake this.name}}).where('{{snake this.name_plural}}.name = ?', row['{{snake this.name}}'])
        {{/each}}
              .first

      L.kv '{{snake settings.MainKey}}', row['{{snake settings.MainKey}}']
{{#each relations_one_to_one}}
      L.kv '{{snake this.name}}', row['{{snake this.name}}']
{{/each}}
        
      if ({{snake settings.Model}})
        L.kv '{{humanize settings.Model}} found (skipped)', row['{{snake settings.MainKey}}']
      else
        {{#each relations_one_to_one}}
        # Todo: currently does not handle duplicates gracefully, ie. you may not get the {{snake this.name}} you wanted
        {{snake this.name}} = {{camelU this.name}}.find_by_name(row['{{snake this.name}}'])

        if {{snake this.name}}.nil?
          L.kv 'ERROR: {{camelU this.name}} not found', row['{{snake this.name}}']
          next
        end

        row['{{snake this.name}}'] = {{snake this.name}}

{{/each}}
        {{camelU settings.Model}}.create!(row)
        L.kv '{{humanize settings.Model}} added', row['{{snake settings.MainKey}}']
      end

    end
  end

end
