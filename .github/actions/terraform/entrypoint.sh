#!/bin/bash


export ARM_CLIENT_ID=${INPUT_ARM_CLIENT_ID}
export ARM_CLIENT_SECRET=${INPUT_ARM_CLIENT_SECRET}
export ARM_SUBSCRIPTION_ID=${INPUT_ARM_SUBSCRIPTION_ID}
export ARM_TENANT_ID=${INPUT_ARM_TENANT_ID}
export STATE_KEY=${INPUT_STATE_KEY}
export TF_STAGE=${INPUT_TF_STAGE}

#cd /github/workspace/.github/actions/terraform/stage1

#terraform init -backend-config="key=${INPUT_STATE_KEY}" -input=false -reconfigure
terraform plan
terraform apply --auto-approve
