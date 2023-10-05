# Super Gitops repository

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

## Getting started


Provision a brand new management cluster called `hub` using terraform.

```text
task: Available tasks for this project:
* master:delete:        Uninstall resources from the master kubernetes cluster.
* master:deploy:        Deploying resources into the master kubernetes cluster.
* master:destroy:       Destroy the master kubernetes cluster using terraform.
* master:install:       Provison the master kubernetes cluster using terraform.
```

To ensure that the current environment is clean.

```shell
task master:destroy -- minikube
```

Provision the master's infrastructure.

*This example uses minikube but you can use any other terraform products in terraform/products.*

```shell
task master:provision -- minikube
```

**Deploy** the master's resources.

```shell
task master:deploy
```

**Delete** the master's resources.

```shell
task master:delete
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
