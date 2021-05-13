puts "_DATA_ENTITIES"

def sample_dsl
  # supported cardinalities: :one_one, :one_many, :many_one
  <<~RUBY
  entities = KBuilder::EntityBuilder
    .init
    
    .entity(:product)
      .columns
        .column(:name)
        .column(:price, :decimal)
    
    .entity(:sale)
      .columns
        .column(:time, :date_time)
        .column(:price, :decimal)
      .relations
        .relation(:item, :one_many, reference_type: :sale_line_item)

    .entity(:sale_line_item)
      .column(:quantity, :int)
      .relation(:product, :many_one)

    .entity(:sale_line_item)
      .column(:quantity, :int)
      .relation(:product, :many_one)
      .relation(:sale, :many_one)

    .entity(:store)
      .column(:trading_name)
      .relation(:terminal, :one_many)
      .relation(:product, :one_many)

    .entity(:terminal)
      .column(:name)
      .relation(:sale, :one_many)
  RUBY
end

def raw_entities
  return @raw_entities if defined? @raw_entities
  @raw_entities = [
    { 
      name: :product,
      columns: [{
        name: :name,
        type: :string
      },
      {
        name: :price,
        type: :decimal
      }]
    },
    { 
      name: :sale,
      columns: [{
        name: :time,
        type: :date_time
      }],
      relations: [{
        name: :item,
        name_plural: nil,
        reference_type: :sale_line_item,  # Entity to reference
        reference_relation: '1:m',         # 1:m, m:m, m:1
        reference_key: nil                # Entity foreign key field
      }]
    },
    { 
      name: :sale_line_item,
      columns: [{
        name: :quantity,
        type: :int
      }],
      relations: [{
        name: :product,
        name_plural: nil,
        reference_type: nil,              # Entity to reference
        reference_relation: 'm:1',        # 1:m, m:m, m:1
        reference_key: nil                # Entity foreign key field
      },
      {
        name: :sale,
        name_plural: nil,
        reference_type: nil,              # Entity to reference
        reference_relation: 'm:1',        # 1:m, m:m, m:1
        reference_key: nil                # Entity foreign key field
      }]
    },
    { 
      name: :store,
      columns: [{
        name: :trading_name,
        type: :string
      }],
      relations: [{
        name: :terminal,
        name_plural: nil,
        reference_type: nil,              # Entity to reference
        reference_relation: '1:m',        # 1:m, m:m, m:1
        reference_key: nil                # Entity foreign key field
      },
      {
        name: :product,
        name_plural: nil,
        reference_type: nil,              # Entity to reference
        reference_relation: '1:m',        # 1:m, m:m, m:1
        reference_key: nil                # Entity foreign key field
      }]
    },
    { 
      name: :terminal,
      columns: [{
        name: :name,
        type: :string
      }],
      relations: [{
        name: :sale,
        name_plural: nil,
        reference_type: nil,              # Entity to reference
        reference_relation: '1:m',        # 1:m, m:m, m:1
        reference_key: nil                # Entity foreign key field
      }]
    }
  ]
end