#!/bin/bash

# bash setup-1.sh
# bash setup-2.sh
# bash setup-3.sh

# kl_cmd 'show PATH before RVM'
# echo $PATH
# kl_cmd_end

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function kl_exit_error {
  echo "missing dependency: $1"
  exit -1
}
function kl_heading {
  kl_line
  echo $1
  kl_line
}
function kl_subheading {
  echo -e "[ \e[93m$1\e[0m ]"
}
function kl_line {
  echo '----------------------------------------------------------------------'
}
function kl_cmd {
  # -n = NO Line Feed
  # echo -n ": $1 : "
  echo -n "[ $1 ]"
}
function kl_cmd_end {
  # echo ":[ OK ]"
  echo " - OK"
}
function kl_cmd_done {
  echo "  $1"
}

kl_heading 'Check Dependancies'

# kl_cmd 'get ruby version'
# ruby -v
# kl_cmd_end

# kl_cmd 'get rails version'
# rails -v
# kl_cmd_end

# kl_cmd 'show PATH'
# echo $PATH
# kl_cmd_end

kl_cmd 'get rvm version'
rvm -v > /dev/null 2>&1 || kl_exit_error 'no RVM'
kl_cmd_end

kl_cmd 'rvm use {{settings.RubyVersion}}'
rvm use {{settings.RubyVersion}} > /dev/null 2>&1 || kl_exit_error 'you do not have ruby version {{settings.RubyVersion}}'
kl_cmd_end

# Setup script for {{camelU settings.Application}}
# This script is designed to run once 

kl_heading 'Setup developer environment'

# Try to drop {{settings.DatabaseName}} if it exists, if it doesnt keep going

# Force existing databases drop
#

kl_cmd 'dropdb {{settings.DatabaseName}}'
dropdb {{settings.DatabaseName}} > /dev/null 2>&1
kl_cmd_end

kl_cmd 'dropdb {{settings.DatabaseName}}_test'
dropdb {{settings.DatabaseName}}_test > /dev/null 2>&1
kl_cmd_end

kl_cmd 'createuser {{settings.DatabaseName}}'
createuser --superuser -w {{settings.DatabaseName}} > /dev/null 2>&1
kl_cmd_end

kl_cmd 'alter role (password is now : {{settings.DatabaseName}})'
psql -c "alter role {{settings.DatabaseName}} password '{{settings.DatabaseName}}'" # > /dev/null 2>&1
kl_cmd_end

kl_cmd 'createdb {{settings.DatabaseName}}'
createdb --owner={{settings.DatabaseName}} {{settings.DatabaseName}}
kl_cmd_end

kl_cmd 'createdb {{settings.DatabaseName}}_test'
createdb --owner={{settings.DatabaseName}} {{settings.DatabaseName}}_test
kl_cmd_end

kl_heading 'rvm gemset list'
rvm gemset list

kl_cmd 'gemset delete (FORCED)'
# rvm --force gemset delete {{dashify settings.Application}}{{settings.RailsVersion}}  > /dev/null 2>&1
rvm --force gemset delete {{settings.Gemset}}  > /dev/null 2>&1
kl_cmd_end

kl_cmd 'create gemset'
# rvm use ruby-{{settings.RubyVersion}}@{{dashify settings.Application}}{{settings.RailsVersion}} --ruby-version --create
rvm use ruby-{{settings.RubyVersion}}@{{settings.Gemset}} --ruby-version --create
kl_cmd_end

kl_heading 'rvm gemset list'
rvm gemset list

kl_heading 'Install Rails'
gem install rails

kl_heading 'Create Rails application for Postgress minus mini-test and with webpack/vue '
rails new . -T -d postgresql --webpack

kl_heading 'bundle install'
bundle install

# kl_heading 'Add webpacker'
# bundle exec rails webpacker:install

kl_heading 'Add webpack/vue'
bundle exec rails webpacker:install:vue

kl_heading 'Add webpack/angular'
bundle exec rails webpacker:install:angular

# Previously setup-2.sh
kl_heading 'Basic rails installation is complete, now lets go on to extend installation'

kl_heading 'Commit and added extra rails generators'

# kl_cmd 'Bundle Install new GEMs'
# bundle install
# kl_cmd_end

kl_cmd 'Commit Initial Application'
# git status
git add .
git commit -am 'Initial Application'
# git status
kl_cmd

kl_cmd 'Stop Spring if it is running'
spring stop
kl_cmd_end

kl_cmd 'Run ActiveAdmin Generator for (admin_user)'
rails generate active_admin:install
rm db/migrate/*_create_active_admin_comments.rb kl_exit_error 'could not remove migration _create_active_admin_comments.rb'
kl_cmd_end

# If this fails, try running 
# spring stop

kl_cmd 'Run Devise Generator and create (user)'
rails generate devise:install
rails generate devise user
kl_cmd_end

kl_cmd 'Setup RSPEC / Guard'
rails generate rspec:install
bundle binstubs rspec-core
bundle binstubs guard
kl_cmd_end

# git status

kl_cmd 'Setup RSPEC / Guard'
git add .
git commit -am 'Addons attached to application ... ActiveAdmin, Devise, Guard and WebPacker'
kl_cmd_end


# echo ''
# echo '----------------------------------------------------------------------'
# echo ''
# echo 'Generate the following assets using software factory'
# echo '* 01 - ReadMe.md'
# echo '* 02 - .gitignore'
# echo '* 02 - GemFile'
# echo ''
# echo 'Then run'
# echo ''
# echo 'bundle install'
# echo '----------------------------------------------------------------------'


echo ''
kl_subheading 'Build Starter Application'

kl_cmd_done 'create develoment database: {{settings.DatabaseName}}'

kl_cmd_done 'create test database: {{settings.DatabaseName}}_test'

kl_cmd_done "createuser '{{settings.DatabaseName}}' with password '{{settings.DatabaseName}}'"

kl_cmd_done "rvm gemset name: '{{dashify settings.ApplicationName}}'"

kl_cmd_done 'install rails'

kl_cmd_done 'create rails microservice/headless server'

kl_cmd_done 'bundle install'

kl_cmd_done 'Add webpacker'

kl_cmd_done 'Add webpack/vue'

kl_cmd_done 'Add webpack/angular'

kl_cmd_done 'git commit - "Initial Application"'

kl_subheading 'Commit and added extra rails generators'

kl_cmd_done 'run ActiveAdmin generator for (admin_user)'

kl_cmd_done 'run ActiveAdmin generator for (user)'

kl_cmd_done 'setup unit test framework: rspec'

kl_cmd_done 'setup automated test runner: guard'

kl_cmd_done 'git commit - "Addons attached to application ... ActiveAdmin, Devise, Guard and WebPacker"'

kl_line

echo ''
echo 'NEXT: Use Klueless.io Software factory'
echo '    generate all custom application files using klueless.io generator'
echo ''
echo 'then'
echo '    create bitbucket repository without readme for "ideasmen" "{{dashify settings.Application}}"'
echo ''
echo '    https://bitbucket.org/ideasmen/{{dashify settings.Application}}/src'
echo ''
echo 'then'
echo '    bash setup-2.sh'
echo ''
echo 'then'
echo '    bash setup-3.sh'
echo ''

