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

### Current: 2023-09-30 / 2023-10-01

Objectives:

- Implement a way for the master k8s cluster to remotly manage factory default VM in a Gitops fashion using ArgoCD.
- Kubernetes node-probleme-detector

Goals:

- Can managed pre provisionned `ON-PREMISE` virtual machines (Ubuntu, centos, etc..)
- Being able to provision standard default kubernetes cluster on the managed VM.
- Need a way to control clusters role attributed to VMs

### 2023-10-02 / 2023-10-05

Objectives:

- Implement a way for the master k8s cluster to bootstrap pre-existing kubernetes cluster in a Gitops fashion using ArgoCD.
