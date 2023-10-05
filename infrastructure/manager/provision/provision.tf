module "minikube" {
  source     = "../../../provisioning/terraform/minikube"
  kubeconfig = "${path.cwd}/minikube.kubeconfig"
}