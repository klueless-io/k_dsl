obj = KDsl.artifact :{{snake name}} do
  microapp     = import(:{{microapp.settings.name}}, :microapp)

  settings do
  end

  table :attributes do
    fields [:active, :name]

    # row 1, :field_1
    # row 1, :field_2
    # row 1, :field_3
    # row 0, :deprecated
  end

  def on_action
    # write_json is_edit: true
  end
end

def obj.on_import(data)
  
end
