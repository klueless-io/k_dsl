# frozen_string_literal: true

KDsl.document :my_name do
  settings do
    a '1'
    b 2
  end

  actions do
    write_json is_edit: true
  end
end
