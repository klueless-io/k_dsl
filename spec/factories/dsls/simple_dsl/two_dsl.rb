# frozen_string_literal: true

KDsl.document :my_name1 do
  settings do
    rails_port 3000
    app_path '~/somepath'
  end
end

KDsl.document :my_name2 do
  s = import(:my_name1).settings

  rows :applets do
    fields [:name, f(:active, true)]

    row name:         'rails5',
        active:       true,
        target_path:  s.app_path

    row name:         'react',
        active:       false,
        target_path:  File.join(s.app_path, 'client')
  end

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
