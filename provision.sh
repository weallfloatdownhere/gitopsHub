#!/usr/bin/env bash

KUBECONFIG="$(git rev-parse --show-toplevel)/kubeconfig.conf"
ARGO_DIR="$GIT_ROOT/administration/resources/argocd/overlays/current"
ARGO_BOOTSTRAP_APP="$GIT_ROOT/administration/bootstrap/app-bootstrap.yaml"

if [[ ! -f "$KUBECONFIG" ]]; then
echo "ERROR - Kubeconfig file ($KUBECONFIG) not found.."
exit 1
fi

kubectl apply -k "$ARGO_DIR"
sleep 1
kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
kubectl apply -f "$ARGO_BOOTSTRAP_APP"