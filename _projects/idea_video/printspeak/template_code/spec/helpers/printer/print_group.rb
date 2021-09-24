# frozen_string_literal: true

# Print helpers for Groups
module Printer
  def print_groups(rows = nil, format: :default)
    log.section_heading "Groups"

    rows = Group.unscoped.all if rows.nil?

    rows.each do |row|
      print_group_detailed(row) if format == :detailed
      print_group(row) if format == :default
    end
  end
  alias print_default_groups print_groups

  def print_groups_as_table(rows = nil, format: :default)
    log.section_heading "Groups"

    rows = Group.unscoped.all if rows.nil?

    tp rows, :id, :name, :group_type, :default, "enterprise.name"
  end
  alias print_default_groups_as_table print_groups_as_table

  def print_group(row)
    log.kv "id", row.id
    log.kv "name", row.name
    log.kv "group_type", row.group_type
    log.kv "default", row.default
    
    # Belongs to relationships
    if row.enterprise
      log.kv "enterprise > name", row.enterprise.name if row.enterprise.name
    end

    log.line
  end

  def print_group_detailed(row)
    log.kv "id", row.id
    log.kv "name", row.name
    log.kv "group_type", row.group_type
    log.kv "created_at", row.created_at
    log.kv "updated_at", row.updated_at
    log.kv "default", row.default
    log.kv "enterprise_id", row.enterprise_id
    
    # Belongs to relationships
    if row.enterprise
      log.kv "enterprise > name", row.enterprise.name if row.enterprise.name
    end

    log.line
  end
end
