KUBECONFIG=${PWD}/manager/manager.kubeconfig

clean:
	- kubectl delete -f manager/bootstrap.yaml
	- kubectl delete ns argocd
	- kubectl delete ns cert-manager
	- kubectl delete ns cluster-api
	- kubectl delete ns capi-operator-system
	- kubectl delete ns argo-rollouts

install:
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cert-manager/overlay | kubectl apply -f -
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -n argocd -f manager/bootstrap.yaml

connect:
	kubectl port-forward -n argocd svc/argocd-server 8080:80