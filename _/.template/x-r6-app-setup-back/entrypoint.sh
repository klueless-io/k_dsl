#!/bin/bash

set -euo pipefail

main() {
  # Export Secrets from SSM Parameter Store with Chamber if a scope if supplied
  if [[ -n ${SSM_PARAMETER_SCOPE+x} ]]; then
    echo "Running with SSM Parameters from \"${SSM_PARAMETER_SCOPE}\""
    chamber exec ${SSM_PARAMETER_SCOPE} -- "$@"
  else
    "$@"
  fi
}

main "$@"
