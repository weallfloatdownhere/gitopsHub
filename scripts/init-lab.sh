#!/usr/bin/env bash

# INITILIZATION STEP
export GIT_ROOT=$(git rev-parse --show-toplevel)

export HUB_MINIKUBE_MEMORY=3078
export HUB_MINIKUBE_CPUS=2

export SPOKE_MINIKUBE_MEMORY=3078
export SPOKE_MINIKUBE_CPUS=2

echo "USAGE: ./init-lab.sh {hub|spoke|all}"
if [[ -z "$1" ]]; then
exit 1
fi

rm -rf ~/.kube/config
$GIT_ROOT/scripts/get-cli-tools.sh

# START HUB LAB STEP
if [[ "$1" == "hub" ]] || [[ "$1" == "all" ]]; then
export NAME="lab-1"
export OUTDIR="$GIT_ROOT/administration/hubs/$NAME"
rm -rf "$OUTDIR" && mkdir -p "$OUTDIR"
export KUBECONFIG="$OUTDIR/kubeconfig.tmp"
minikube delete -p "$NAME"
minikube start -p "$NAME" --memory $HUB_MINIKUBE_MEMORY --cpus $HUB_MINIKUBE_CPUS --network bridge
kubectl config view --context "$NAME" --minify --flatten > $KUBECONFIG.tmp
rm -rf $KUBECONFIG && mv $KUBECONFIG.tmp $KUBECONFIG
KUBECONFIG="$KUBECONFIG" $GIT_ROOT/scripts/init-hub.sh
fi

# START SPOKE LAB STEP
if [[ "$1" == "spoke" ]] || [[ "$1" == "all" ]]; then
export NAME="lab-1"
export OUTDIR="$GIT_ROOT/environments/laboratory/spokes/$NAME"
rm -rf "$OUTDIR" && mkdir -p "$OUTDIR"
kubectl config view --context "$NAME" --minify --flatten > $KUBECONFIG.tmp
rm -rf $KUBECONFIG && mv $KUBECONFIG.tmp $KUBECONFIG
minikube delete -p "$NAME"
minikube start -p "$NAME" --memory $SPOKE_MINIKUBE_MEMORY --cpus $SPOKE_MINIKUBE_CPUS --network bridge
kubectl config view --minify --flatten > $KUBECONFIG
fi

#cp $KUBECONFIG ~/.kube/config
#echo "FILE AT: $KUBECONFIG"
