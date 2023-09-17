#!/usr/bin/env bash

export SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
export GIT_ROOT=$(git rev-parse --show-toplevel)
export KUBECONFIG="$SCRIPT_DIR/kubeconfig.$NAME"

if [[ -z "$NAME" ]]; then
echo """
USAGE:
NAME=clustername ./minicluster.sh
"""
exit 1
fi

rm -rf ~/.kube/config
rm -rf $KUBECONFIG
minikube delete -p "$NAME"
minikube start -p "$NAME" --network bridge