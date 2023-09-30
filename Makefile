local:
	bash hack/scripts/init-local-env.sh

tools:
	test $(command -v kubectl) || (sudo apt-get -y update sudo apt-get install -y kubectl)

clean:
	export KUBECONFIG=${PWD}/manager/manager.kubeconfig
	- kubectl delete -f manager/bootstrap.yaml
	- kubectl delete app bootstrap -n argocd
	- kubectl delete ns argocd

install:
	make tools
	export KUBECONFIG=${PWD}/manager/manager.kubeconfig
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl apply -n argocd -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f manager/bootstrap.yaml

connect:
	kubectl port-forward -n argocd svc/argocd-server 8080:80