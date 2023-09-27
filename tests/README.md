# How to test this repository locally.
Todo..

# Requirements

```shell
# Ubuntu
$ apt-get install virtualbox docker.io
```

## [Minikube](https://minikube.sigs.k8s.io/docs/start/)

```shell
# Linux AMD64
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

# Getting started
Todo..

1. Provision a vanilla Kubernetes clustere which will act as Manager in the infrastructure.

```shell
$ minikube start -p manager --memory 3078 --cpus 2 --network bridge
```

**If something goes wrong and need to reset the cluster to default, use the command below..**

```shell
# Remove the manager cluster
$ minikube delete -p manager
# Remove all
$ minikube delete --all
```

2. Download the newly provisionned minikube cluster.

```shell
$ kubectl config view --context manager --flatten --minify > manager.kubeconfig
```

3. We can new deploy the manager's resources on the minikube cluster using the kubeconfig file `manager.kubeconfig` generated earlier.

```shell
$ export KUBECONFIG="/path/to/manager.kubeconfig"
$ cd manager/
$ make install
```