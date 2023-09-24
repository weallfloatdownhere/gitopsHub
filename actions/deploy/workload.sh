#!/usr/bin/env bash

set -o pipefail

GIT_ROOT=$(git rev-parse --show-toplevel)

USAGE="./$(basename "$0") [KUBECONFIG] [CONTEXT]"

if [[ -z "${1}" ]] || [[ -z "${2}" ]] ; then
  echo "$USAGE"
  exit 1
elif [ ! -f "$(realpath "${1}")" ]; then
  echo "ERROR - Specified kubeconfig file not found: $(realpath "${1}")"
  exit 1
fi

export CONTEXT="${2}"
export KUBECONFIG="$(realpath "${1}")"

read -p "You are about to bootstrap a workload kubernetes cluster.
Kubeconfig file : $KUBECONFIG
Context         : $CONTEXT

Press ENTER to continue or CTRL-C to Abort..."



# here bootstrap with capi or argo or sum shit like that..
# request token