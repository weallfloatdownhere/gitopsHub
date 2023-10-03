# Super Gitops repository

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started

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
