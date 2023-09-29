ARGO_FLAVOR=flamingo
KUBECONFIG=${PWD}/manager/manager.kubeconfig

clean:
	- kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cert-manager/overlay | kubectl delete -f -
	- kubectl delete ns argo-rollouts
	- kubectl delete ns cert-manager
	- kubectl delete ns cluster-api
	- kubectl delete ns capi-operator-system
	- kubectl delete ns kyverno
	- kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl delete -f -
	- kubectl delete ns argocd

install:
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cert-manager/overlay | kubectl apply -f -
	kustomize build --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay/$(ARGO_FLAVOR) | kubectl apply -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -n argocd -f manager/bootstrap.yaml

connect:
	kubectl port-forward -n argocd svc/argocd-server 8080:80