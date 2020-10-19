#!/bin/bash

# bash setup-1.sh
# bash setup-2.sh
# bash setup-3.sh

# kl_cmd 'show PATH before RVM'
# echo $PATH
# kl_cmd_end

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

kl_cmd 'get ruby version'
ruby -v
kl_cmd_end

# kl_cmd 'get rails version'
# rails -v
# kl_cmd_end

kl_cmd 'show PATH'
echo $PATH
kl_cmd_end

# Setup script for 
# project     : {{camelU settings.project}}
# application : {{camelU settings.application}}
#
# This script is designed to run once

kl_heading 'Setup developer environment'

# Try to drop {{settings.database_name}} if it exists, if it doesnt keep going

# Force existing databases drop
#

kl_cmd 'dropdb {{settings.database_name}}_development'
dropdb {{settings.database_name}}_development > /dev/null 2>&1
kl_cmd_end

kl_cmd 'dropdb {{settings.database_name}}_test'
dropdb {{settings.database_name}}_test > /dev/null 2>&1
kl_cmd_end

kl_cmd 'createuser {{settings.database_name}}'
createuser --superuser -w {{settings.database_name}}_development > /dev/null 2>&1
kl_cmd_end

kl_cmd 'alter role (password is now : {{settings.database_name}})'
psql -c "alter role {{settings.database_name}} password '{{settings.database_name}}'" # > /dev/null 2>&1
kl_cmd_end

kl_cmd 'createdb {{settings.database_name}}_development'
createdb --owner={{settings.database_name}} {{settings.database_name}}_development
kl_cmd_end

kl_cmd 'createdb {{settings.database_name}}_test'
createdb --owner={{settings.database_name}} {{settings.database_name}}_test
kl_cmd_end

kl_heading 'Install Rails'
gem install rails

kl_heading 'Create Rails application for Postgress minus mini-test and with webpack/vue '
rails new . -T -d postgresql --force --skip-action-mailer --skip-action-mailbox --skip-action-text

# The following are not needed for most microservers
# 

# --webpack

# Options:
# --skip-namespace        --no-skip-namespace                       # Skip namespace (affects only isolated applications)
# --ruby=PATH                                                       # Path to the Ruby binary of your choice
#                                                                   # Default: /Users/davidcruwys/.rbenv/versions/2.5.3/bin/ruby
# --template=TEMPLATE                                               # Path to some application template (can be a filesystem path or URL)
# --database=DATABASE                                               # Preconfigure for selected database (options: mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc)
#                                                                   # Default: sqlite3
# --skip-gemfile          --no-skip-gemfile                         # Don't create a Gemfile
# --skip-git              --no-skip-git                             # Skip .gitignore file
# --skip-keeps            --no-skip-keeps                           # Skip source control .keep files
# --skip-action-mailer    --no-skip-action-mailer                   # Skip Action Mailer files
# --skip-action-mailbox   --no-skip-action-mailbox                  # Skip Action Mailbox gem
# --skip-action-text      --no-skip-action-text                     # Skip Action Text gem
# --skip-active-record    --no-skip-active-record                   # Skip Active Record files
# --skip-active-storage   --no-skip-active-storage                  # Skip Active Storage files
# --skip-puma             --no-skip-puma                            # Skip Puma related files
# --skip-action-cable     --no-skip-action-cable                    # Skip Action Cable files
# --skip-sprockets        --no-skip-sprockets                       # Skip Sprockets files
# --skip-spring           --no-skip-spring                          # Don't install Spring application preloader
# --skip-listen           --no-skip-listen                          # Don't generate configuration that depends on the listen gem
# --skip-javascript       --no-skip-javascript                      # Skip JavaScript files
# --skip-turbolinks       --no-skip-turbolinks                      # Skip turbolinks gem
# --skip-test             --no-skip-test                            # Skip test files
# --skip-system-test      --no-skip-system-test                     # Skip system test files
# --skip-bootsnap         --no-skip-bootsnap                        # Skip bootsnap gem
# --dev                   --no-dev                                  # Setup the application with Gemfile pointing to your Rails checkout
# --edge                  --no-edge                                 # Setup the application with Gemfile pointing to Rails repository
# --rc=RC                                                           # Path to file containing extra configuration options for rails command
# --no-rc                 --no-no-rc                                # Skip loading of extra configuration options from .railsrc file
# --api                   --no-api                                  # Preconfigure smaller stack for API only apps
# --skip-bundle           --no-skip-bundle                          # Don't run bundle install
# --webpacker             --webpack=WEBPACK                         # Preconfigure Webpack with a particular framework (options: react, vue, angular, elm, stimulus)
# --skip-webpack-install  --no-skip-webpack-install                 # Don't run Webpack install

# Runtime options:
# --force                                                           # Overwrite files that already exist
# --pretend               --no-pretend                              # Run but do not make any changes
# --quiet                 --no-quiet                                # Suppress status output
# --skip                  --no-skip                                 # Skip files that already exist

# Rails options:
# --help                  --no-help                                 # Show this help message and quit
# --version               --no-version                              # Show Rails version number and quit

exit 1

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

kl_cmd_done 'create develoment database: {{settings.database_name}}'

kl_cmd_done 'create test database: {{settings.database_name}}_test'

kl_cmd_done "createuser '{{settings.database_name}}' with password '{{settings.database_name}}'"

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

