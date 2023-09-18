#!/usr/bin/env bash

# INITILIZATION STEP
export GIT_ROOT=$(git rev-parse --show-toplevel)
export KUBECTL_CLI="$GIT_ROOT/scripts/kubectl"
export VCLUSTER_CLI="$GIT_ROOT/scripts/vcluster"

export HUB_MINIKUBE_MEMORY=3078
export HUB_MINIKUBE_CPUS=2
export HUB_OUTPUT_DIR="$GIT_ROOT/administration/hubs"

export SPOKE_MINIKUBE_MEMORY=3078
export SPOKE_MINIKUBE_CPUS=2
export SPOKE_OUTPUT_DIR="$GIT_ROOT/environments/laboratory/spokes"

if [[ -z "$1" ]]; then
echo "USAGE: ./init-lab.sh {hub|spoke|all}"
exit 1
fi

rm -rf ~/.kube/config
$GIT_ROOT/scripts/get-cli-tools.sh

# START HUB LAB STEP
if [[ "$1" == "hub" ]] || [[ "$1" == "all" ]]; then
export NAME="hub-lab-1"
export OUTDIR="$HUB_OUTPUT_DIR/$NAME"
rm -rf "$OUTDIR" && mkdir -p "$OUTDIR"
export KUBECONFIG="$OUTDIR/kubeconfig.tmp"
minikube delete -p "$NAME"
minikube start -p "$NAME" --memory $HUB_MINIKUBE_MEMORY --cpus $HUB_MINIKUBE_CPUS --network bridge
KUBECONFIG="$KUBECONFIG" $GIT_ROOT/scripts/init-hub.sh
fi

# START SPOKE LAB STEP
if [[ "$1" == "spoke" ]] || [[ "$1" == "all" ]]; then
export NAME="spoke-lab-1"
export OUTDIR="$SPOKE_OUTPUT_DIR/$NAME"
rm -rf "$OUTDIR" && mkdir -p "$OUTDIR"
export KUBECONFIG="$OUTDIR/kubeconfig.tmp"
minikube delete -p "$NAME"
minikube start -p "$NAME" --memory $SPOKE_MINIKUBE_MEMORY --cpus $SPOKE_MINIKUBE_CPUS --network bridge
fi

#cp $KUBECONFIG ~/.kube/config
#echo "FILE AT: $KUBECONFIG"
