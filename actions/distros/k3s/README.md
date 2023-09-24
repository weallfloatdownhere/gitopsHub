# [Lightweight Kubernetes distribution](https://github.com/k3s-io/k3s)

Lightweight Kubernetes. Production ready, easy to install, half the memory, all in a binary less than 100 MB.

# What is this?

K3s is a fully conformant production-ready Kubernetes distribution with the following changes:

It is packaged as a single binary.
It adds support for sqlite3 as the default storage backend. Etcd3, MySQL, and Postgres are also supported.
It wraps Kubernetes and other components in a single, simple launcher.
It is secure by default with reasonable defaults for lightweight environments.
It has minimal to no OS dependencies (just a sane kernel and cgroup mounts needed).
It eliminates the need to expose a port on Kubernetes worker nodes for the kubelet API by exposing this API to the Kubernetes control plane nodes over a websocket tunnel.

## Quick start

### K3sUp installation

```bash
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/
k3sup --help
```