#!/bin/bash

# rbenv install 2.6.3
rbenv local 2.6.3
# rbenv rehash
gem install rails -v {{settings.rails_version}}
docker image build -t x-application .
echo '-------------------------------------------------------------------'
echo ' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT'
pwd
cat .ruby_version
echo ' TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT'
echo '-------------------------------------------------------------------'
echo ':: rails -v'
rails -v

echo ':: rbenv local'
rbenv local

echo ':: rbenv version'
rbenv version

echo ':: rbenv versions'
rbenv versions

# eval "$(rbenv init - --no-rehash)"

echo ':: rails -v'
rails -v

echo '$PATH'
echo $PATH

# echo ':: rbenv shell {{settings.ruby_version}}'
# rbenv shell {{settings.ruby_version}}

echo ':: rbenv version -afterward'
rbenv version

echo '$PATH'
echo $PATH


# kl_heading 'Create Rails application for Postgress with Rspec and with webpack '

echo ':: rails -v - afterword'
rails -v


#rails _{{settings.rails_version}}_ new . -d postgresql --force --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-spring --skip-test --skip-bundle --skip-webpack-install
