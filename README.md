# Super Gitops repository.

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started

Todo..

## Development

Todo..

## Cluster-api providers

| Type                 | Provider                                                                                      |
| -------------------- | --------------------------------------------------------------------------------------------- |
| CoreProvider         | [Operator](https://github.com/kubernetes-sigs/cluster-api-operator)                           |
| ControlPlaneProvider | [Kubeadm](https://github.com/kubernetes-sigs/cluster-api/tree/main/controlplane/kubeadm)      |
| BootstrapProvider    | [Kubeadm](https://github.com/kubernetes-sigs/cluster-api/tree/main/bootstrap/kubeadm)         |
| Infrastructure       | [docker](https://github.com/kubernetes-sigs/cluster-api/tree/main/test/infrastructure/docker) |
| Infrastructure       | [byoh](https://github.com/vmware-tanzu/cluster-api-provider-bringyourownhost)                 |
| Infrastructure       | [Metal3](https://github.com/metal3-io/cluster-api-provider-metal3)                            |

## Ansible

[Metal3 virtual machines setup playbook](https://github.com/metal3-io/metal3-dev-env/tree/main/vm-setup)

## Powered by

Todo..

## Resources

- https://metal3.io/blog/2022/07/08/One_cluster_multiple_providers.html
