# frozen_string_literal: true

puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxA'
KDsl.document :my_name1 do
end

puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxB'
KDsl.document :my_name2 do
end

# puts 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
# KDsl::Model::Document.new :my_name do
#   my_csv = import(:abc)
#   settings do
#     rails_port 3000
#   end


#   # my_csv.each do |row|
#   #   puts row.series_refernce
#   # end
# end
