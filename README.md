# Super Gitops repository.

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Table of content

- [Flux cli](https://fluxcd.io/flux/cmd/flux)

    - [Flux bootstraping process](https://fluxcd.io/flux/installation/bootstrap/)
        
        - [Github repository](https://fluxcd.io/flux/installation/bootstrap/github/)

        - [Bitbucket repository](https://fluxcd.io/flux/installation/bootstrap/bitbucket/)

        - [Gitlab repository](https://fluxcd.io/flux/installation/bootstrap/gitlab/)

        - [Generic git repository](https://fluxcd.io/flux/installation/bootstrap/generic-git-server/)


## Getting started

TODO..



## Cluster-api providers

<ol>

| Type                 | Provider                                                                                      |
| -------------------- | --------------------------------------------------------------------------------------------- |
| CoreProvider         | [Operator](https://github.com/kubernetes-sigs/cluster-api-operator)                           |
| ControlPlaneProvider | [Kubeadm](https://github.com/kubernetes-sigs/cluster-api/tree/main/controlplane/kubeadm)      |
| BootstrapProvider    | [Kubeadm](https://github.com/kubernetes-sigs/cluster-api/tree/main/bootstrap/kubeadm)         |
| Infrastructure       | [docker](https://github.com/kubernetes-sigs/cluster-api/tree/main/test/infrastructure/docker) |
| Infrastructure       | [byoh](https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost)                 |
| Infrastructure       | [Metal3](https://github.com/metal3-io/cluster-api-provider-metal3)                            |

</ol>

## Ansible

- [Metal3 virtual machines setup playbook](https://github.com/metal3-io/metal3-dev-env/tree/main/vm-setup)


## Repos

- [Tf-controller - A GitOps Terraform controller for Kubernetes.](https://github.com/weaveworks/tf-controller)


## Resources

<ol>

## ArgoCD
- https://argo-cd.readthedocs.io/en/stable/operator-manual/applicationset/Progressive-Syncs
- https://raw.githubusercontent.com/argoproj/argo-cd/v2.8.4/manifests/install.yaml
- https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/argocd-cmd-params-cm.yaml
- https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/argocd-cm.yaml
- https://github.com/argoproj/argo-cd/blob/master/docs/operator-manual/argocd-secret.yaml


## ArgoCD rollouts
- https://victoryeo-62924.medium.com/getting-started-with-argo-cd-and-argo-rollout-757fc37ea8e8
- https://github.com/argoproj/argo-rollouts/releases/download/v1.6.0/install.yaml

## Cluster-api
- https://metal3.io/blog/2022/07/08/One_cluster_multiple_providers.html

## Cert-manager
- https://github.com/cert-manager/cert-manager

## Flamingo ArgoCD Flux subsystem
- https://flux-subsystem-argo.github.io/website/tutorials/terraform/
- https://github.com/flux-subsystem-argo/flamingo

</ol>

## Powered by

Todo..
