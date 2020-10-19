#!/bin/bash

set -euxo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# bash setup-1.sh
# bash setup-2.sh
# bash setup-3.sh

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


kl_heading 'bundle install'

bundle install

kl_heading 'Add webpacker'
bundle exec rails webpacker:install

# kl_heading 'Add webpack/vue'
# bundle exec rails webpacker:install:vue

# kl_heading 'Add webpack/angular'
# bundle exec rails webpacker:install:angular

kl_heading 'Add webpack/react'
bundle exec rails webpacker:install:react
