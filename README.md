# Super Gitops repository

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started

Provision a brand new management cluster called `hub` using terraform.

To ensure that the current environment is clean.

```shell
$ cd $(git rev-parse --show-toplevel)/environments/hub/infra
$ task terraform:destroy PRODUCT=minikube
```

Provision the hub.

```shell
$ cd $(git rev-parse --show-toplevel)/environments/hub/infra
$ task terraform:install PRODUCT=minikube
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
