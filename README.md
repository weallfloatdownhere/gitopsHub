# Super Gitops repository

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started

If you dont already have access to a running Kubernetes cluster, you can start the local minikube environment using the command below. If the provisioning complete succesfully, the newly genarated KUBECONFIG file (minikube.kubeconfig) should be located in the root of the repository.

<u>Please note that if you made a mistake going through the steps, you can always revert the environment using the same command</u>

```bash
make -C provisioning/kubernetes/minikube start
```

You can now deploy resources on the management cluster.

```bash
KUBECONFIG=/path/to/my/kubeconfig make install
```

## Stories

### Current

Objectives:

- [Install and Setup Istio Operator](https://istio.io/latest/docs/setup/install/operator)
- Install and Setup Istio using the Operator
- Setup Istio monitoring

### 2st

Objectives:

- Cluster API provider Bring Your Own Hosts
- Bootstrap script using either, bash, ansible, or something better ?
- See the VMs in the ArgoCD UI

### 3st

Objectives:

- Implement a way for the master k8s cluster to bootstrap pre-existing kubernetes cluster in a Gitops fashion using ArgoCD.
