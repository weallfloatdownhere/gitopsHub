# gitopsHub
Repository that manages the HUB part of a multi-clusters. multi-tenancy, gitops driven whole Kubernetes infrastructure.

# Getting started

The `Hub` is a complete up and running Kubernetes cluster. The sole purpose of this cluster is to ultimatly give Devops operator
a centrilized way of managing an almost infinite amount of other Kubernetes clusters called `Spokes`.


- [ArgoCD - Declarative continuous deployment for Kubernetes.](https://github.com/argoproj/argo-cd)
- [Kyverno - Kubernetes Native Policy Management.](https://github.com/kyverno/kyverno)
- [Crossplane - Cloud Native Control Planes.](https://github.com/crossplane/crossplane)


## Sources
- https://github.com/kyverno/policies

## References
- https://github.com/kyverno/policies/tree/main/argo
- https://github.com/codefresh-contrib/kubecon-eu-2023-demo-crossplane-vcluster
- https://argo-cd.readthedocs.io/en/stable/user-guide/diffing/#system-level-configuration
- https://github.com/kyverno/policies/tree/main/argo/argo-cluster-generation-from-rancher-capi
- https://github.com/argoproj/argo-cd/issues/4651