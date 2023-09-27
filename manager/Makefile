clean:
	kubectl delete -k argo-cd/overlay
	kubectl delete namespace argocd --force

install:
	kubectl apply -k argo-cd/overlay
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f apps/root.yaml -n argocd