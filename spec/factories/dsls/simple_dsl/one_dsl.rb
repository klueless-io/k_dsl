# frozen_string_literal: true

KDsl.document :my_name do
  settings do
    a '1'
    b 2
  end

  def on_action
    write_json is_edit: true
  end
end
