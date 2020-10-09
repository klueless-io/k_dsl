# frozen_string_literal: true

KDsl.document :my_name1 do
  settings do
    rails_port 3000
    app_path '~/somepath'
  end
end

KDsl.document :my_name2 do
  s = import(:my_name1).settings
  # csv = import('sample.csv', 'csv')

  rows :applets do
    fields [:name, f(:active, true)]

    row name:         'rails5',
        active:       true,
        target_path:  s.app_path

    row name:         'react',
        active:       false,
        target_path:  File.join(s.app_path, 'client')
  end

  actions do
    # puts 'run action'
    # csv.each do |row|

    #   L.subheading "#{row.name} #{row.last_name}"
    #   L.kv 'Name', row.name
    #   L.kv 'Title', row.title
    # end
  end

end
