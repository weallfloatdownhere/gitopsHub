.EXPORT_ALL_VARIABLES:

KUBECONFIG=${PWD}/manager/manager.kubeconfig

req:
	- curl -sLS https://get.arkade.dev | sudo sh
	- arkade get kubectl
	- arkade get kustomize
	- arkade get helm
	- arkade get yq

hooks:
	./.hooks/run.sh

local:
	export KUBECONFIG=$(KUBECONFIG)
	cd local/ && make start

install:
	export KUBECONFIG=$(KUBECONFIG)
	make hooks
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/applications/argo-cd/head | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/bootstrap/bootstrap.yaml
	kubectl port-forward -n argocd svc/argocd-server 8080:80