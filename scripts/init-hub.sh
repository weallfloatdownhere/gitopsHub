#!/usr/bin/env bash

GIT_ROOT=$(git rev-parse --show-toplevel)
ARGO_DIR="$GIT_ROOT/administration/resources/argocd/overlays/current"
ARGO_BOOTSTRAP_APP="$GIT_ROOT/administration/bootstrap/app-bootstrap.yaml"

kubectl apply -k "$ARGO_DIR"
sleep 1
kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
kubectl apply -f "$ARGO_BOOTSTRAP_APP"