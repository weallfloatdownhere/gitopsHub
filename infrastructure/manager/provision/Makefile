install:
	terraform init -reconfigure -cloud=false -lock=false
	terraform plan
	terraform apply -auto-approve -lock=false

clean:
	- terraform apply -auto-approve -destroy
	- rm -rf ${PWD}/.terraform
	- rm -rf ${PWD}/.*.hcl
	- rm -rf ${PWD}/.*.lock.hcl
	- rm -rf ${PWD}/*.tfstate
	- rm -rf ${PWD}/*.tfstate.backup
	- rm -rf ${PWD}/plan.tf
	- rm -rf ${PWD}/minikube.kubeconfig