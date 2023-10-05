variable "name" {
  type     = string
  default  = "manager"
  nullable = false
}

variable "cpus" {
  type    = number
  default = 2
  nullable = false
}

variable "memory" {
  type    = number
  default = 3096
  nullable = false
}

resource "null_resource" "minikube" {
  triggers = {
      name            = var.name
  }
  provisioner "local-exec" {
    command       = "minikube delete -p ${self.triggers.name}"
    interpreter   = ["bash", "-c"]
    on_failure    = continue
    when          = destroy
    environment   = { KUBECONFIG = "${path.cwd}/private/cluster.kubeconfig" }
  }
}

resource "terraform_data" "provision" {
  provisioner "local-exec" {
    interpreter   = ["bash", "-c"]
    command = <<-EOT
      minikube start -p ${var.name} --cpus 2 --memory 3096 --network bridge
      kubectl config view --context manager --flatten --minify > ${path.cwd}/private/cluster.kubeconfig.tmp
      mv ${path.cwd}/private/cluster.kubeconfig.tmp ${path.cwd}/private/cluster.kubeconfig
    EOT
    environment   = { KUBECONFIG = "${path.cwd}/private/cluster.kubeconfig" }
  }
}