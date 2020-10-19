#!/bin/sh

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

kl_heading 'Extended Application Features'

kl_subheading 'automation scripts'
kl_cmd_done 'help'
kl_cmd_done 'migrations (test/dev)'
kl_cmd_done 'rollbacks (test/dev)'
kl_cmd_done 'git sychronzation'
kl_cmd_done 'git hotfix'
kl_cmd_done 'git versioning'
kl_cmd_done 'git hooks + custom rules, e.g. prevent debuggers'


kl_subheading 'admin module'
kl_cmd_done 'material theme'
kl_cmd_done 'addons'
kl_cmd_done 'advanced dashboard'
kl_cmd_done 'statistics'
kl_cmd_done 'menu'
kl_cmd_done 'types - citext, date, readonly, time etc.'

kl_subheading 'application'
kl_cmd_done 'layout'
kl_cmd_done 'header and footer'
kl_cmd_done 'common pages'

kl_subheading 'configuration'
kl_cmd_done 'custom port: {{settings.RailsPort}}'
kl_cmd_done 'database configuration - dev + test'
kl_cmd_done 'auto load libraries'
kl_cmd_done 'custom log formatter'
kl_cmd_done 'custom rspec settings'
kl_cmd_done 'custom default routes'
kl_cmd_done 'environment customizations'
kl_cmd_done 'CORS'

kl_subheading 'REST API'
kl_cmd_done 'base classes'
kl_cmd_done 'common data objects'
kl_cmd_done 'sample endpoints "poor mans swagger"'
kl_cmd_done "routes 'REST'"

kl_subheading 'common services / library'
kl_cmd_done 'base services'
kl_cmd_done 'application settings '
kl_cmd_done 'application settings - unit tests'
kl_cmd_done 'bulk importer - upserter (seed, tests, production, pilots)'
kl_cmd_done 'base firestore'
kl_cmd_done 'base query engine'
kl_cmd_done 'graphql engine - COMMING'
kl_cmd_done 'spreadsheet readers'
kl_cmd_done 'extensions - string, number, date, boolean, nil'
kl_cmd_done 'validators - json, '
kl_cmd_done 'types - jsonb, '
kl_cmd_done 'database helpers'
kl_cmd_done 'synchronization'
kl_cmd_done 'util'

kl_subheading 'SQL scripts'
kl_cmd_done 'statistics (group + subgroups) - live'
kl_cmd_done 'statistics (group + subgroups) - cached'
kl_cmd_done 'reset'

kl_subheading 'seed data'
kl_cmd_done 'admin user'
kl_cmd_done 'setup framework for domain model seed data'
kl_cmd_done 'yaml readers'
kl_cmd_done 'spreadsheet readers'
kl_cmd_done 'data reset'

kl_subheading 'test data'
kl_cmd_done 'common '

kl_subheading 'unit testing'
kl_cmd_done 'generic helpers'
kl_cmd_done 'generic debug print formatters'
kl_cmd_done 'generic test data helpers'
kl_cmd_done 'generic expecations'
kl_cmd_done 'common sub-module helpers'
kl_cmd_done ' :: bulk upsert'


kl_subheading 'angular 8'
kl_cmd_done 'architecture application'
kl_cmd_done 'sample endpoints'

kl_subheading 'vue 2'
kl_cmd_done 'architecture application'
kl_cmd_done 'sample endpoints'
