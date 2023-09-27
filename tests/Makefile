clean:
	minikube delete -p manager
	rm -rf ${PWD}/tmp.kubeconfig ${PWD}/manager.kubeconfig

install:
	KUBECONFIG=${PWD}/manager.kubeconfig
	minikube start -p manager --memory 3078 --cpus 2 --network bridge
	kubectl config view --flatten --minify --context manager > ${PWD}/tmp.kubeconfig
	mv ${PWD}/tmp.kubeconfig ${PWD}/manager.kubeconfig