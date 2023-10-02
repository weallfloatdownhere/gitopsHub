.EXPORT_ALL_VARIABLES:
.PHONY: install

KUBECONFIG=${PWD}/manager/manager.kubeconfig

local:
	export KUBECONFIG=$(KUBECONFIG)
	cd local-dev && make start

install:
	export KUBECONFIG=$(KUBECONFIG)
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/applications/argo-cd/head | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/bootstrap/bootstrap.yaml
	
	kubectl port-forward -n argocd svc/argocd-server 8080:80