puts "_DATA"

def entities
  return @entities if defined? @entities
  @entities = begin
    raw_entities
      .each do |e|
        e[:columns]&.each do |c|
          c[:name_plural] = pluralize.parse(c[:name].to_s) if c[:name_plural].nil?
          c[:type] = entity_map_type(c[:type])
        end
        e[:relations]&.each do |r|
          r[:name_plural] = pluralize.parse(r[:name].to_s) if r[:name_plural].nil?
          r[:reference_type] = r[:name] if r[:reference_type].nil?
          r[:reference_key] = "#{r[:name]}_id" if r[:reference_key].nil?
        end
        e[:relations_1m] = e[:relations]&.select { |r| r[:reference_relation] == '1:m'}
        e[:relations_mm] = e[:relations]&.select { |r| r[:reference_relation] == 'm:m'}
        e[:relations_m1] = e[:relations]&.select { |r| r[:reference_relation] == 'm:1'}
      end
  end
  # name: :item,
  # name_plural: nil,
  # reference_type: :sale_line_item,  # Entity to reference
  # reference_relation: '1M',         # 1M, MM, M1
  # reference_key: nil                # Entity foreign key field

  @entities
end

def entity_map_type(type)
  return type if [:string, :int, :decimal].include?(type)

  camel.parse(type.to_s)
end
