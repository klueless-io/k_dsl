# run shell
# docker container run -it klueless/rails6:ruby-2.6.5-alpine ash

# Components
# Rails 6
# Ruby 2.6.5
# Node 10.16.3

# References that may be useful
# https://jer-k.github.io/update-gem-dockerfile-alpine-linux/

FROM klueless/rails6-base:ruby-2.6.5-alpine

ENV APP_PATH /usr/src/app

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

ADD Gemfile $APP_PATH
# ADD Gemfile.lock $APP_PATH
# Install newest version of bundler to prevent Gemfile.lock conflicts
RUN gem install bundler
# bundle install using parrallel CPU cores
RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

# Copy the application into the container
COPY . $APP_PATH

EXPOSE {{settings.rails_port}}

CMD ["bundle", "exec", "thin", "--address", "0.0.0.0", "start"]
