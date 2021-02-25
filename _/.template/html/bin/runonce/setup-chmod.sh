#!/bin/bash

source 'common.sh'

kl_heading 'Give execute rights to files'

kl_subheading 'pwd'
pwd

kl_cmd 'chmod +x ../kgitsync'
chmod +x ../kgitsync
kl_cmd_end

kl_cmd 'chmod +x ../khotfix'
chmod +x ../khotfix
kl_cmd_end
