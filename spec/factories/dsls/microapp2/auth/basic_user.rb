# Klue.artifact :basic_user, visitors: [Klue::Dsl::ArtifactSettingsVisitor] do

#   settings do
#     rails_port           3000                # Move into Application Settings (or support a merge concept)
#     model_type           'BasicUser'
#     model                'User'
#     main_key             'email'
#     note                 'password is an alias to encrypted_password'

#     # Can this be in a test data use case object
#     td_key1              'david'
#     td_key2              'jin'
#     td_key3              'lisa'
#     td_query             ['01', '02', '03', '04', '10', '11', '12', '13']
#   end

#   db_table = rows :db_table do

#     fields [:name, f(:type, 'String'), f(:title, "''"), f(:default,'null'), f(:required, true), :reference_type, :db_type, :format_type, :description]
    
#     row :id                      , 'PrimaryKey'  , db_type: 'primarykey'
#     row :email                                   , format_type: 'email'
#     row :password
#     row :reset_password_token
#     row :reset_password_sent_at  , 'DateTime'    , db_type: 'datetime'
#     row :remember_created_at     , 'DateTime'    , db_type: 'datetime'

#   end

#   rows do
#     fields db_table.get_fields
    
#     row db_table.find_row :name, :id
#     row db_table.find_row :name, :email
#   end

#   rows :virtual_properties do
#     fields db_table.get_fields

#     row :password
#   end

#   #  type: :record
#   rows :relations do
#     fields [:name, :name_plural, :field, :type, :json, :main_key, :td_key1, :td_key2, :td_key3]
#   end

#   write_data 'spec/_data/domain/common-auth/basic_user.json'
#   # write_data 'spec/_data/domain/common-auth/basic_user.yaml'

#   # write_meta 'spec/_data/domain/common-auth/basic_user-meta.json'
#   # write_meta 'spec/_data/domain/common-auth/basic_user-meta.yaml'

  
# end
