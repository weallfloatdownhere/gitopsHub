.EXPORT_ALL_VARIABLES:

KUBECONFIG=${PWD}/manager/manager.kubeconfig

local:
	export KUBECONFIG=$(KUBECONFIG)
	cd .tasks/dev/minikube && task start

tools:
	sudo apt-get -y update
	sudo apt-get install -y kubectl
	curl -s https://fluxcd.io/install.sh | sudo bash

clean:
	- kubectl delete -f manager/bootstrap.yaml
	- kubectl delete app bootstrap -n argocd
	- kubectl delete ns argocd

install:
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/bootstrap.yaml

connect:
	kubectl port-forward -n argocd svc/argocd-server 8080:80