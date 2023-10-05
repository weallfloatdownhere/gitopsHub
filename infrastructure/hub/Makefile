TERRAFORM_CLUSTER_VARFILE:=${PWD}/private/cluster.tfvars
TERRAFORM_MODULE_PATH:=../../provisioning/terraform/minikube

install:
	test -f ${TERRAFORM_CLUSTER_VARFILE}
	terraform -chdir=${TERRAFORM_MODULE_PATH} validate
	terraform -chdir=${TERRAFORM_MODULE_PATH} init -reconfigure -cloud=false -lock=false
	terraform -chdir=${TERRAFORM_MODULE_PATH} plan -var-file=${TERRAFORM_CLUSTER_VARFILE}
	terraform -chdir=${TERRAFORM_MODULE_PATH} apply -var-file=${TERRAFORM_CLUSTER_VARFILE} -auto-approve -lock=false

clean:
	- terraform -chdir=${TERRAFORM_MODULE_PATH} apply -var-file=${TERRAFORM_CLUSTER_VARFILE} -auto-approve -destroy
	- rm -rf ${TERRAFORM_MODULE_PATH}/.terraform
	- rm -rf ${TERRAFORM_MODULE_PATH}/.*.hcl
	- rm -rf ${TERRAFORM_MODULE_PATH}/.*.lock.hcl
	- rm -rf ${TERRAFORM_MODULE_PATH}/*.tfstate
	- rm -rf ${TERRAFORM_MODULE_PATH}/*.tfstate.backup
	- rm -rf ${TERRAFORM_MODULE_PATH}/plan.tf
	- rm -rf ${PWD}/private/*.kubeconfig