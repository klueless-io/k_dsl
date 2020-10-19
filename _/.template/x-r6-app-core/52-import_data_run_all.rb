module ImportDataRunAll

  def run_all

    settings = open_settings()

{{#each models}}
    # Import Sample/Seed data for {{titleize (humanize this.names)}}
    if settings['{{snake this.name}}'] && settings['{{snake this.name}}']['can_import']
      L.heading 'Import {{camelU this.name}}'
      {{snake this.names}} = open('{{snake this.name}}.yaml')

      if ({{snake this.names}}.present?)
        import_{{snake this.name}}({{snake this.names}})
      end
    end

{{/each}}
  end

end