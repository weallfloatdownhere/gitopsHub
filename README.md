# Super Gitops repository.

Structured repository to managed a fleet of Kubernetes clusters in an opionated way.

# Stories

## Current: 2023-09-30 / 2023-10-01

Objectives:

- Implement a way for the master k8s cluster to remotly manage factory default VM in a Gitops fashion using ArgoCD.
- Kubernetes problem

Goals:

- Can managed pre provisionned `ON-PREMISE` virtual machines (Ubuntu, centos, etc..)
- Being able to provision standard default kubernetes cluster on the managed VM.
- Need a way to control clusters role attributed to VMs

## 2023-10-02 / 2023-10-05

### Implement a way for the master k8s cluster to bootstrap pre-existing kubernetes cluster in a Gitops fashion using ArgoCD.