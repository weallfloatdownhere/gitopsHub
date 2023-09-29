KUBECONFIG=${PWD}/manager/manager.kubeconfig

clean:
	kubectl delete -f manager/bootstrap.yaml
	kubectl delete -f manager/apps/argocd.yaml
	kubectl delete -f manager/apps/argo-rollouts.yaml
	kubectl delete -f manager/apps/cert-manager.yaml
	kubectl delete -f manager/apps/cluster-api.yaml
	kubectl delete -f manager/apps/cluster-api-operator.yaml
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cluster-api/overlay | kubectl delete -f -
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cluster-api-operator/overlay | kubectl delete -f -
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cert-manager/overlay | kubectl delete -f -
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argo-rollouts/overlay | kubectl delete -f -
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl delete -f -
	kubectl delete ns argocd
	kubectl delete ns argo-rollouts
	kubectl delete ns cert-manager
	kubectl delete ns capi-operator-system
	kubectl delete ns cluster-api

install:
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cert-manager/overlay | kubectl apply --wait -f -
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argocd/overlay | kubectl apply --wait -f -
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/argo-rollouts/overlay | kubectl apply --wait -f -
	kubectl apply -k manager/resources/cluster-api-operator/overlay
	kustomize build --enable-helm --enable-alpha-plugins --load-restrictor=LoadRestrictionsNone manager/resources/cluster-api/overlay | kubectl apply --wait -f -
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -n argocd -f manager/bootstrap.yaml

connect:
	kubectl port-forward -n argocd svc/argocd-server 8080:80