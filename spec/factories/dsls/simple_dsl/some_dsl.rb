# frozen_string_literal: true

puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
KDsl::Model::Document.new :my_name do
  settings do
    rails_port 3000
  end
end
