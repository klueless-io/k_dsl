#!/bin/bash

source 'common.sh'

kl_heading 'Build a new rails application in docker'

kl_heading $(pwd)

kl_cmd 'create new rails application in docker for klueless/web-{{settings.database_name}}'
cd ..
docker container run -v $(pwd):/usr/src/app -it klueless/web-{{dashify settings.application}} rails new . -T -d postgresql --force --skip-action-mailer --skip-action-mailbox --skip-action-text
kl_cmd_end

# The following are not needed for most microservers
# 

rails new . -T -d postgresql \
  --force \
  --skip-bundle

  --skip-bundle
  --skip-action-mailer \
  --skip-action-mailbox \
  --skip-action-text

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


