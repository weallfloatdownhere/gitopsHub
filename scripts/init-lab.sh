#!/usr/bin/env bash

MINIKUBE_MEMORY=8192
MINIKUBE_CPUS=2

rm -rf ~/.kube/config
export GIT_ROOT=$(git rev-parse --show-toplevel)
export KUBECTL_CLI="$GIT_ROOT/scripts/kubectl"
export VCLUSTER_CLI="$GIT_ROOT/scripts/vcluster"

export NAME="lab-hub"
export KUBECONFIG="$GIT_ROOT/scripts/kubeconfig.$NAME.kubeconfig.tmp"

$GIT_ROOT/scripts/get-cli-tools.sh

if [[ "$1" == "-f" ]] || [[ ! -f "$KUBECONFIG" ]]; then
rm -rf $KUBECONFIG
minikube delete -p "$NAME"
fi

# start the cluster
minikube start -p "$NAME" --memory $MINIKUBE_MEMORY --cpus $MINIKUBE_CPUS --network bridge
# init the Hub cluster
KUBECONFIG="$KUBECONFIG" $GIT_ROOT/scripts/init-hub.sh

cp $KUBECONFIG ~/.kube/config
echo "FILE AT: $KUBECONFIG"
