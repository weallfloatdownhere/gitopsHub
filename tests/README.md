# How to test this repository locally.
Todo..

# Dependencies

## Requirements

```shell
# Ubuntu
$ sudo apt-get install git curl virtualbox docker.io
```

### [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

```shell
# Linux x86-64
$ curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

### [Minikube](https://minikube.sigs.k8s.io/docs/start/)

```shell
# Linux AMD64
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

# Getting started

Provision a vanilla Kubernetes cluster which will act as Manager in the infrastructure.

```shell
$ minikube start -p manager --memory 3078 --cpus 2 --network bridge
```

***If something goes wrong and need to reset the cluster to default, use the command below..***

```shell
# Remove the manager cluster
$ minikube delete -p manager
# Remove all
$ minikube delete --all
```

Download the newly provisionned minikube cluster.

```shell
$ kubectl config view --flatten --minify --context manager > manager.kubeconfig
```

We can new deploy the manager's resources on the minikube cluster using the kubeconfig file `manager.kubeconfig` generated earlier.

```shell
$ export KUBECONFIG="/path/to/manager.kubeconfig"
$ cd manager/
$ make install
```

At this point, you should be able to use kubectl to create a tunnel between the ArgoCD web interface service running in the minikube manager cluster. Assuming that the $KUBECONFIG variable is still pointint to the `manager.kubeconfig` file. Execute the command below then visit the mapped service at **https://127.0.0.1:8080/** using the following default credentials: **admin:password**

**Please note that since we dont provide a valid TLS certificate for the service, you will most likely have to ignore an encryption warnings.**

```shell
# username: admin
# password: password
$ kubectl port-forward -n argocd svc/argocd-server 8080:80
```
