#!/bin/bash

source 'common.sh'

# If running via Docker, you may need to connect using psql and then run the scripts manually
psql -U postgres -h 127.0.0.1

# drop database {{settings.database_name}}_development;
# drop database {{settings.database_name}}_test;
# drop user {{settings.database_name}};
# create user {{settings.database_name}} SUPERUSER;
# alter role {{settings.database_name}} password '{{settings.database_name}}';
# create database {{settings.database_name}}_development OWNER {{settings.database_name}};
# create database {{settings.database_name}}_test OWNER {{settings.database_name}};


# If Postgres is local, then use the script technique
kl_heading 'Setup development and test database'

kl_cmd 'dropdb {{settings.database_name}}_development'
dropdb {{settings.database_name}}_development > /dev/null 2>&1
kl_cmd_end

kl_cmd 'dropdb {{settings.database_name}}_test'
dropdb {{settings.database_name}}_test > /dev/null 2>&1
kl_cmd_end

kl_cmd 'dropuser {{settings.database_name}}'
dropuser {{settings.database_name}} > /dev/null 2>&1
kl_cmd_end

kl_cmd 'createuser {{settings.database_name}}'
createuser --superuser -w {{settings.database_name}} > /dev/null 2>&1
kl_cmd_end

kl_cmd 'alter role (password is now : {{settings.database_name}})'
psql -c "alter role {{settings.database_name}} password '{{settings.database_name}}'" > /dev/null 2>&1
kl_cmd_end

kl_cmd 'createdb {{settings.database_name}}_development'
createdb --owner={{settings.database_name}} {{settings.database_name}}_development
kl_cmd_end

kl_cmd 'createdb {{settings.database_name}}_test'
createdb --owner={{settings.database_name}} {{settings.database_name}}_test
kl_cmd_end


