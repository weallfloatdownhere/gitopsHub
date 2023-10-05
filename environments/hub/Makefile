TERRAFORM_PRODUCT:=minikube

GIT_ROOT:=$(shell git rev-parse --show-toplevel)
TERRAFORM_CLUSTER_VARFILE:=${PWD}/infra/cluster.tfvars
TERRAFORM_PRODUCT_PATH:=${GIT_ROOT}/provisioning/terraform/products
TERRAFORM_MODULE_PATH:=${TERRAFORM_PRODUCT_PATH}/${TERRAFORM_PRODUCT}

install:
	test -f ${TERRAFORM_CLUSTER_VARFILE}
	terraform validate
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
	- rm -rf ${PWD}/infra/*.kubeconfig