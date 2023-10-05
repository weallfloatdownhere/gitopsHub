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
    interpreter   = ["bash", "-c"]
    environment   = { KUBECONFIG = "${path.cwd}/cluster.kubeconfig" }
    command = <<-EOT
      minikube delete -p ${self.triggers.name}
      rm -rf ${path.cwd}/*.kubeconfig
      rm -rf ${path.cwd}/*.tfstate
      rm -rf ${path.cwd}/*.tfstate.backup
    EOT
    on_failure    = continue
    when          = destroy
  }
}

resource "terraform_data" "provision" {
  provisioner "local-exec" {
    interpreter   = ["bash", "-c"]
    environment   = { KUBECONFIG = "${path.cwd}/cluster.kubeconfig" }
    command = <<-EOT
      minikube start -p ${var.name} --cpus ${var.cpus} --memory ${var.memory} --network bridge
      kubectl config view --context ${var.name} --flatten --minify > ${path.cwd}/cluster.kubeconfig.tmp
      mv ${path.cwd}/cluster.kubeconfig.tmp ${path.cwd}/cluster.kubeconfig
    EOT
  }
}