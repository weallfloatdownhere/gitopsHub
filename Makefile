install:
	kubectl apply -k bootstrap/argocd/overlay
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f bootstrap/bootstrap.yaml -n argocd