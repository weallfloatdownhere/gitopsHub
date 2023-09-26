#!/usr/bin/env bash

sudo apt-get -y update
sudo apt install -y docker.io virtualbox
sudo systemctl enable docker.service --now
sudo systemctl enable containerd.service --now
sudo systemctl daemon-reload
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /bin/minikube
sudo rm -rf minikube-linux-amd64