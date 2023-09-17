#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
GIT_ROOT=$(git rev-parse --show-toplevel)

if [[ -z "$NAME" ]]; then
echo """
USAGE:
NAME=clustername ./minicluster.sh
"""
exit 1
fi

export KUBECONFIG="$SCRIPT_DIR/kubeconfig.$NAME"
minikube delete -p "$NAME"
minikube start -p "$NAME" --network bridge