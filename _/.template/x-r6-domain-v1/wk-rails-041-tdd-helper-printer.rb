module Printer

  # ---------------------------------------------
  # Print {{camelU settings.Models}}
  # ---------------------------------------------

  def p_{{snake settings.Models}}(rows = nil, format = 'default')

    L.block '{{camelU settings.Models}}'

    if (rows.nil?)
      {{camelU settings.Model}}.all.each do |r|
        p_{{snake settings.Model}}_with_format(r, format)
      end
    else
      rows.each do |r|
        p_{{snake settings.Model}}_with_format(r, format)
      end
    end
  end

  def p_{{snake settings.Models}}_as_table(rows = nil, format = 'default')

    L.block '{{camelU settings.Models}}'

    if (rows.nil?)
      rows = {{camelU settings.Model}}.all
    end

    case format
    when 'detailed'
      tp rows
    when 'gsheet'
      tp rows, :sample_key, :test_key{{#ifx settings.no_key '==' true}}{{else}}, :sync_{{snake settings.MainKey}}{{/ifx}}{{#each relations_one_to_one}}, :sync_fk_{{snake this.name}}{{/each}}{{#each rows}}, :{{snake this.name}}{{/each}}
    else
      tp rows{{#each rows_fields_and_pk}}, :{{snake this.name}}{{/each}}{{#each relations_one_to_one}}, '{{snake this.name}}.{{snake this.main_key}}'{{/each}}
    end
  end

  def p_{{snake settings.Model}}_with_format(r, format)
    case format
      when 'detailed'
        p_{{snake settings.Model}}_detailed(r)
      else
        p_{{snake settings.Model}}(r)
    end
  end

  def p_{{snake settings.Model}}(r)
    {{#each rows}}
    L.kv '{{snake this.name}}', r.{{snake this.name}}
    {{/each}}
    L.line
  end

  def p_{{snake settings.Model}}_detailed(r)
    {{#each rows}}
    L.kv '{{snake this.name}}', r.{{snake this.name}}
    {{/each}}

    # Print Relations
    {{#each relations_one_to_one}}
    if (r.{{snake this.name}})
      L.kv '{{snake this.name}}.name', r.{{snake this.name}}.name
    end
    {{/each}}

    L.line
  end

end