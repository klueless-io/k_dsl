# frozen_string_literal: true

KDsl.microapp :basic_app do
  settings do
    name                          "#{parent.key}"
    app_path                      "#{Dir.getwd}/spec/.output/#{parent.key}"
  end
end
