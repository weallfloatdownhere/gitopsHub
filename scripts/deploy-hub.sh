#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
GIT_ROOT=$(git rev-parse --show-toplevel)

if [[ -z "$KUBECONFIG" ]]; then
echo "USAGE: KUBECONFIG=~/.kube/config ./deploy-hub.sh"
exit 1
elif [[ ! -f "$KUBECONFIG" ]]; then
echo "ERROR - Specified kubeconfig file not found."
exit 1
fi

kubectl apply -k "$GIT_ROOT/administration/resources/argocd/overlays/current"
sleep 1
kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
# kubectl apply -f "$GIT_ROOT/administration/resources/root.yaml"
