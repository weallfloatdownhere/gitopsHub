.EXPORT_ALL_VARIABLES:
.PHONY: install

KUBECONFIG=${PWD}/manager/manager.kubeconfig

tools:
	if [ ! -x "$(shell command -v kubectll)" ]; then curl "https://dl.k8s.io/release/$(shell curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o ${HOME}/.local/bin/kubectl; fi

local:
	export KUBECONFIG=$(KUBECONFIG)
	cd tests/local-env && make start

clean:
	export KUBECONFIG=$(KUBECONFIG)
	kubectl delete -f manager/apps/bootstrap.yaml
	kubectl delete app bootstrap -n argocd
	kubectl delete ns argocd

install:
	export KUBECONFIG=$(KUBECONFIG)
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/apps/bootstrap.yaml

connect:
	export KUBECONFIG=$(KUBECONFIG)
	kubectl port-forward -n argocd svc/argocd-server 8080:80