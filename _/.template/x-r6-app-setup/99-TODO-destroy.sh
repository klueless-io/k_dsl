#!/bin/bash

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

kl_heading 'Cleanup this app'

# Try to drop {{settings.database_name}} if it exists, if it doesnt keep going

# Force existing databases drop
#

kl_cmd 'dropdb {{settings.database_name}}_development'
dropdb {{settings.database_name}}_development > /dev/null 2>&1
kl_cmd_end

kl_cmd 'dropdb {{settings.database_name}}_test'
dropdb {{settings.database_name}}_test > /dev/null 2>&1
kl_cmd_end

rm -rf {{settings.app_path}}
# {{debug_values 'MICROAPP DATA'}}
# {{debug_values microapp}}
# {{debug_values 'SETTINGS DATA'}}
# {{debug_values settings}}
