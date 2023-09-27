KUBECONFIG=${PWD}/manager/manager.kubeconfig

clean:
	kubectl delete -f manager/resources/cert-manager
	kubectl delete -k bootstrap/argocd/overlay
	kubectl delete ns argocd

install:
	kubectl apply -n argocd -k bootstrap/argocd/overlay
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -n argocd -f bootstrap/bootstrap.yaml