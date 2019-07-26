#!/bin/bash
# Output all commands run and fail if any fail
set -e -x

cd aks_advnet_rbac

# Init terraform using the defined storage account 

env

terraform init \
  -backend-config="storage_account_name=${TFSTATE_STORAGE}"
  
# Generate a terraform plan file
terraform plan \
  -input=false \
  -var="ARM_CLIENT_ID=${ARM_CLIENT_ID}" \
  -var="ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET}" \
  -out=plan.tfplan
  
# Apply the terraform plan
terraform apply plan.tfplan
