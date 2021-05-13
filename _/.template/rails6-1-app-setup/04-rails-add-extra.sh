#!/bin/bash

source 'common.sh'

kl_heading 'Run installation for Rails and Yarn'

cd ..

# docker container run --rm -it klueless/rails6
# bundle install --local
# yarn install

# rails webpacker:install
# rails webpacker:install:react

# kl_cmd 'Run ActiveAdmin Generator for (admin_user)'
# rails generate active_admin:install
# rm db/migrate/*_create_active_admin_comments.rb kl_exit_error 'could not remove migration _create_active_admin_comments.rb'
 
# rails generate devise:install
# rails generate devise user

# rails generate rspec:install
# bundle binstubs rspec-core
# bundle binstubs guard

# git init
# git add .
# git commit -am 'Initial Application'

# kl_cmd 'run gem/yarn install with the new microservice gem file'
# docker container run --rm -it klueless/rails6 bundle install --local
# docker container run --rm -it klueless/rails6 yarn install
# kl_cmd_end

# kl_heading 'Add webpack/react'
# docker container run --rm -v $(pwd):/usr/src/app -it klueless/rails6 rails webpacker:install:react
# kl_cmd

# kl_cmd 'Run ActiveAdmin Generator for (admin_user)'
# docker container run --rm -v $(pwd):/usr/src/app -it klueless/rails6 rails generate active_admin:install
# rm db/migrate/*_create_active_admin_comments.rb kl_exit_error 'could not remove migration _create_active_admin_comments.rb'
# kl_cmd_end
 
# kl_cmd 'Run Devise Generator and create (user)'
# docker container run --rm -v $(pwd):/usr/src/app -it klueless/rails6 rails generate devise:install
# docker container run --rm -v $(pwd):/usr/src/app -it klueless/rails6 rails generate devise user
# kl_cmd_end

# kl_cmd 'Setup RSPEC / Guard'
# docker container run --rm -v $(pwd):/usr/src/app -it klueless/rails6 rails generate rspec:install
# bundle binstubs rspec-core
# bundle binstubs guard
# kl_cmd_end


# kl_cmd 'Commit Initial Application'
# git init
# git add .
# git commit -am 'Initial Application'
# kl_cmd_end
