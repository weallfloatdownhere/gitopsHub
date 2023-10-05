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

variable "kubeconfig" {
  type     = string
  nullable = false
}

resource "null_resource" "minikube" {
  triggers = {
      kubeconfig      = var.kubeconfig
      name            = var.name
  }
  provisioner "local-exec" {
    command       = "minikube delete -p ${self.triggers.name}"
    interpreter   = ["bash", "-c"]
    on_failure    = continue
    when          = destroy
    environment   = { KUBECONFIG = self.triggers.kubeconfig }
  }
}

resource "terraform_data" "provision" {
  provisioner "local-exec" {
    interpreter   = ["bash", "-c"]
    command = <<-EOT
      minikube start -p ${var.name} --cpus 2 --memory 3096 --network bridge
      kubectl config view --context manager --flatten --minify > ${var.kubeconfig}.tmp
      mv ${var.kubeconfig}.tmp ${var.kubeconfig}
    EOT
    environment   = { KUBECONFIG = var.kubeconfig }
  }
}