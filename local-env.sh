#/bin/bash

GIT_ROOT="$(git rev-parse --show-toplevel)"
CONTEXT="manager"
KUBECONFIG="$GIT_ROOT/manager/manager.kubeconfig"

rm -rf $KUBECONFIG
minikube delete -p manager| true
minikube start -p manager --memory 3078 --cpus 2 --network bridge

kubectl config view --context $CONTEXT --flatten --minify > "$GIT_ROOT/k.tmp"
mv "$GIT_ROOT/k.tmp" $KUBECONFIG

echo "Kubeconfig file available at: $KUBECONFIG"