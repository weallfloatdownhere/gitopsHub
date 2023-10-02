# Super Gitops repository

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started

Assuming that you already have access to a running Kubernetes cluster and the `kubeconfig` file to interact with it, you now have to create a **secret file**. Follow the steps below to generate it.

```txt
export SOURCE_REPO=[GITOPS REPOSITORY URL]
export SOURCE_KUBECONFIG=[BASE64 ENCODED KUBECONFIG FILE CONTENT]
```

## Manager features and sync-waves

[Official documentation](https://argo-cd.readthedocs.io/en/stable/user-guide/sync-waves/)

Argo CD executes a sync operation in a number of steps. At a high-level, there are three phases pre-sync, sync and post-sync.

Within each phase you can have one or more waves, that allows you to ensure certain resources are healthy before subsequent resources are synced.

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
