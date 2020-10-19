#!/bin/bash

#set -euxo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

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

# kl_cmd 'dropdb {{settings.database_name}}_development'
# dropdb {{settings.database_name}}_development > /dev/null 2>&1
# kl_cmd_end

# kl_cmd 'dropdb {{settings.database_name}}_test'
# dropdb {{settings.database_name}}_test > /dev/null 2>&1
# kl_cmd_end

# kl_cmd 'createuser {{settings.database_name}}'
# createuser --superuser -w {{settings.database_name}}_development > /dev/null 2>&1
# kl_cmd_end

# kl_cmd 'alter role (password is now : {{settings.database_name}})'
# psql -c "alter role {{settings.database_name}} password '{{settings.database_name}}'" # > /dev/null 2>&1
# kl_cmd_end

# kl_cmd 'createdb {{settings.database_name}}_development'
# createdb --owner={{settings.database_name}} {{settings.database_name}}_development
# kl_cmd_end

# kl_cmd 'createdb {{settings.database_name}}_test'
# createdb --owner={{settings.database_name}} {{settings.database_name}}_test
# kl_cmd_end

kl_heading 'Install Rails'
gem install rails -v {{settings.rails_version}}
rbenv shell {{settings.ruby_version}}

rbenv

# kl_heading 'Create Rails application for Postgress with Rspec and with webpack '

rails -v

# Options:
# --template=TEMPLATE                                               # Path to some application template (can be a filesystem path or URL)
# --database=DATABASE                                               # Preconfigure for selected database (options: mysql/postgresql/sqlite3/oracle/frontbase/ibm_db/sqlserver/jdbcmysql/jdbcsqlite3/jdbcpostgresql/jdbc)

# --skip-gemfile          --no-skip-gemfile                         # Don't create a Gemfile
# --skip-action-mailer    --no-skip-action-mailer                   # Skip Action Mailer files
# --skip-action-mailbox   --no-skip-action-mailbox                  # Skip Action Mailbox gem
# --skip-action-text      --no-skip-action-text                     # Skip Action Text gem
# --skip-spring           --no-skip-spring                          # Don't install Spring application preloader
# --skip-test             --no-skip-test                            # Skip test files
# --skip-system-test      --no-skip-system-test                     # Skip system test files
# --skip-bootsnap         --no-skip-bootsnap                        # Skip bootsnap gem
# --skip-bundle           --no-skip-bundle                          # Don't run bundle install
# --skip-webpack-install  --no-skip-webpack-install                 # Don't run Webpack install
# --force                                                           # Overwrite files that already exist


echo 'SHOULD CREATE A RAILS APP using VERSION {{settings.rails_version}} on RUBY {{settings.ruby_version}}'

echo 'rails -v'
rails -v

echo 'rbenv local'
rbenv local

echo 'rbenv version'
rbenv version

echo 'rbenv versions'
rbenv versions

rails _{{settings.rails_version}}_ new . -d postgresql --force --skip-action-mailer --skip-action-mailbox --skip-action-text --skip-spring --skip-test --skip-bundle --skip-webpack-install

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

