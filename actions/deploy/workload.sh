#!/usr/bin/env bash

set -o pipefail

if [[ -z "${1}" ]] || [[ -z "${2}" ]] ; then
  echo "./$(basename "$0") [KUBECONFIG] [CONTEXT]"
  exit 1
elif [ ! -f "$(realpath "${1}")" ]; then
  echo "ERROR - Specified kubeconfig file not found: $(realpath "${1}")"
  exit 1
fi

export GIT_ROOT=$(git rev-parse --show-toplevel)
export CONTEXT="${2}"
export KUBECONFIG="$(realpath "${1}")"

# here bootstrap with capi or argo or sum shit like that..
# request token