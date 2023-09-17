#!/usr/bin/env bash

rm -rf ~/.kube/config
export GIT_ROOT=$(git rev-parse --show-toplevel)
export KUBECTL_CLI="$GIT_ROOT/scripts/kubectl"
export VCLUSTER_CLI="$GIT_ROOT/scripts/vcluster"

$GIT_ROOT/scripts/_get-cli-tools.sh

export NAME="lab-hub"
export KUBECONFIG="$GIT_ROOT/tests/kubeconfig.$NAME.kubeconfig"

if [[ "$1" == "-f" ]] || [[ ! -f "$KUBECONFIG" ]]; then
rm -rf $KUBECONFIG
minikube delete -p "$NAME"
fi

# start the cluster
minikube start -p "$NAME" --network bridge

# init the Hub cluster
KUBECONFIG="$KUBECONFIG" $GIT_ROOT/scripts/init-hub.sh

cp $KUBECONFIG ~/.kube/config
echo "FILE AT: $KUBECONFIG"
