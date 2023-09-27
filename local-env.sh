#/bin/bash

GIT_ROOT="$(git rev-parse --show-toplevel)"
CONTEXT="manager"
KUBECONFIG="$GIT_ROOT/manager/manager.kubeconfig"

minikube delete --all
rm -rf $KUBECONFIG
minikube start -p manager --memory 3078 --cpus 2 --network bridge

kubectl config view --context $CONTEXT --flatten --minify > "$GIT_ROOT/k.tmp"
mv "$GIT_ROOT/k.tmp" $KUBECONFIG

if test -f $KUBECONFIG; then
make install
fi

kubectl port-forward -n argocd svc/argocd-server 8080:80