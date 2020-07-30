# Klue.microapp :my_app do

#   s = settings do
#     name                'my-app'
#     app_path            "~/dev/bug-#{name}"
#     data_path           "_/.data"
#   end

#   rows :applets do
#     fields [:name, f(:active, true), :technology, :description]

#     row name:         'rails5',
#         active:       true,
#         technology:   'rails5',
#         description:  'Rails 6 headless server providing API access',
#         target_path:  s.app_path

#     row name:         'react',
#         active:       'true',
#         technology:   'react	',
#         description:  'React client application communicating with server via API',
#         target_path:  File.join(s.app_path, 'client')
#   end
# end
