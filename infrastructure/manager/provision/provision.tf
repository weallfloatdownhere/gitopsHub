module "minikube" {
  source     = "../../../provisioning/terraform/minikube"
  kubeconfig = "${path.cwd}/minikube.kubeconfig"
  cpus       = 2
  memory     = 2048
}