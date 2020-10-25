obj = KDsl.artifact :template_options do
  microapp     = import(:k_dsl, :microapp)

  settings do
    # template '# I am a template'

    template <<~RUBY
    {{#each grouped_rows.rows}}
    # {{titleize this.group}}
    
    {{#each this.props}}
    attr_accessor :{{this.field}}
    {{/each}}
    {{/each}}
    RUBY

    output '# template output'

  end

  table :attributes do
    fields [:active, :name]

    row 1, :field_1
    row 1, :field_2
    row 1, :field_3
    row 0, :deprecated
  end

  def on_action
    write_json is_edit: true
  end
end

# THIS DOES NOT WORK, need a better solution
# def obj.on_import(data)

#   L.error '----------------------------------------------------------------------'
#   data.active_attributes = OpenStruct.new(rows: data.attributes.rows.select { |p| p.active == 1 })
#   L.o data
#   L.error '----------------------------------------------------------------------'

#   # grouped_attributes = data.active_attributes
#   #                    .rows
#   #                    .group_by { |x| x.group }
#   #                    .map { |g,rows| { group: g, props: rows.map { |r| r.to_h } } }
  
#   # data.grouped_attributes = OpenStruct.new(rows: KDsl::Util.data.to_struct(grouped_attributes))

#   # L.o data
#   # data

# end
