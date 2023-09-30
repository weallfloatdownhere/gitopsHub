.EXPORT_ALL_VARIABLES:

KUBECONFIG=${PWD}/manager/manager.kubeconfig

tools:
	sudo apt-get -y update
	sudo apt-get install -y kubectl
	curl -s https://fluxcd.io/install.sh | sudo bash

local:
	export KUBECONFIG=$(KUBECONFIG)
	cd .tasks/dev/minikube && task start

clean:
	export KUBECONFIG=$(KUBECONFIG)
	kubectl delete -f manager/bootstrap.yaml
	kubectl delete app bootstrap -n argocd
	kubectl delete ns argocd

install:
	export KUBECONFIG=$(KUBECONFIG)
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/bootstrap.yaml

connect:
	export KUBECONFIG=$(KUBECONFIG)
	kubectl port-forward -n argocd svc/argocd-server 8080:80