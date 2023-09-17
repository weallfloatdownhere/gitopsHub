#!/usr/bin/env bash

export GIT_ROOT=$(git rev-parse --show-toplevel)
export KUBECONFIG="$GIT_ROOT/kubeconfig.$NAME"

if [[ -z "$NAME" ]]; then
echo """
USAGE:
NAME=demo-hub ./init-lab.sh
"""
exit 1
fi

rm -rf ~/.kube/config
rm -rf $KUBECONFIG
minikube delete -p "$NAME"
minikube start -p "$NAME" --network bridge
cp $KUBECONFIG ~/.kube/config