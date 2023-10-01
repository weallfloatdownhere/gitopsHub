# Super Gitops repository.

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Manager features and sync-waves

[Official documentation](https://argo-cd.readthedocs.io/en/stable/user-guide/sync-waves/)

Argo CD executes a sync operation in a number of steps. At a high-level, there are three phases pre-sync, sync and post-sync.

Within each phase you can have one or more waves, that allows you to ensure certain resources are healthy before subsequent resources are synced.

| Wave | Application           | Source                                            |
| ---- | --------------------- | ------------------------------------------------- |
| 1    | Cert-manager          |                                                   |
| 1    | Kubernetes-replicator | https://github.com/mittwald/kubernetes-replicator |
| 2    | ArgoCD                | https://github.com/argoproj/argo-cd               |
| 2    | Argo-rollouts         |                                                   |
| 3    | Cluster-api-operator  |                                                   |
| 3    | Kyverno               |                                                   |
| 4    | Cluster-api           |                                                   |
| 4    | Kyverno-policies      |                                                   |
| 5    | Node-problem-detector |                                                   |

## Stories

### Current

Objectives:

- Cluster API provider Bring Your Own Hosts
- Bootstrap script using either, bash, ansible, or something better ?
- See the VMs in the ArgoCD UI

### 2st

Objectives:

- Cluster API provider Bring Your Own Hosts
- Bootstrap script using either, bash, ansible, or something better ?
- See the VMs in the ArgoCD UI

### 3st

Objectives:

- Implement a way for the master k8s cluster to bootstrap pre-existing kubernetes cluster in a Gitops fashion using ArgoCD.
