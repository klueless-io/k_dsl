#!/bin/bash

source 'common.sh'

kl_heading 'Setup docker'

kl_cmd 'build docker image klueless/web-{{dashify settings.application}}'
docker image build -t klueless/web-{{dashify settings.application}} ../.
kl_cmd_end
