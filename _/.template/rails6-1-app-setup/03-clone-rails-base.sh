#!/bin/bash

source 'common.sh'

kl_heading 'Build a new rails application in docker'

cd ..
kl_heading $(pwd)

kl_cmd 'copy rails 6 base image'
cp /Users/davidcruwys/dev/base/rails-6.0.1/**/* /Users/davidcruwys/dev/bug/bug-{{dashify settings.application}}
kl_cmd_end
