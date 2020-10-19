# run shell
# docker container run -it klueless/rails6:ruby-2.6.5-alpine ash

# Components
# Rails 6
# Ruby 2.6.5
# Node 10.16.3

# References that may be useful
# https://jer-k.github.io/update-gem-dockerfile-alpine-linux/

FROM klueless/rails6:latest

ADD Gemfile $APP_PATH

# bundle install using parrallel CPU cores
RUN \ 
    bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3 \
&&  echo "BUNDLE IS DONE" \
&&  yarn install \
&&  echo "YARN IS DONE" \
&&  rails generate active_admin:install \
&&  echo "ACTIVE:ADMIN IS DONE" \
&&  rails generate devise:install \
&&  echo "DEVISE:ADMIN IS DONE" \
&&  rails generate devise user \
&&  echo "DEVISE:USER IS DONE"
# &&   \
# &&  rails generate active_admin:install 
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



# RUN rails webpacker:install # NOT currently working, because I (think) don't have configuration files

# Copy the application into the container
COPY . $APP_PATH

EXPOSE {{settings.rails_port}}

# CMD ["bundle", "exec", "thin", "--address", "0.0.0.0", "start"]
CMD ['rails', 's']