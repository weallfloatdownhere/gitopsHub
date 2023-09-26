CONTEXT='manager'
WORKSPACE=${PWD}/workspace

dependencies:
	sudo apt-get -y update
	sudo apt install -y qemu ebtables dnsmasq-base
	sudo apt install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
	sudo apt install -y docker.io vagrant virtualbox
	sudo groupadd docker
	sudo groupadd libvirt
	sudo usermod -aG libvirt ${USER}
	sudo usermod -aG docker ${USER}
	vagrant plugin install vagrant-libvirt
	sudo systemctl enable docker.service --now
	sudo systemctl enable containerd.service --now
	sudo systemctl daemon-reload
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /bin/minikube
	sudo rm -rf minikube-linux-amd64

clean:
	virsh undefine .workspace_cluster | true
	virsh vol-delete --pool default .workspace_cluster.img | true
	minikube delete --all --purge
	docker system prune --force --all
	sudo systemctl restart docker
	sudo systemctl restart containerd
	sudo systemctl daemon-reload
	rm -rf $(WORKSPACE) k.tmp .vagrant
	cd $(WORKSPACE)/ && vagrant destroy --force | true



minikube:
	mkdir -p ${WORKSPACE}
	KUBECONFIG=${WORKSPACE}/kubeconfig-minikube-manager
	minikube delete -p $(CONTEXT)
	minikube start -p $(CONTEXT) --memory 3078 --cpus 2 --network bridge
	kubectl config view --context $(CONTEXT) --flatten --minify > k.tmp
	mv k.tmp $(KUBECONFIG)

vagrantbox:
	mkdir -p $(WORKSPACE)
	cp Vagrantfile $(WORKSPACE)/Vagrantfile
	cd $(WORKSPACE)/ && vagrant up --provision --provider=libvirt



manager:
	KUBECONFIG=${WORKSPACE}/kubeconfig-minikube-manager
	kubectl apply -k ../management/resources/argocd/overlays/current
	kubectl wait --for=condition=available deployment -l "app.kubernetes.io/name=argocd-server" -n argocd --timeout=300s
	kubectl apply -f ../management/root.yaml -n argocd
	nohup kubectl port-forward -n argocd svc/argocd-server 8080:80 &
	nohup python3 -m webbrowser https://localhost:8080 &