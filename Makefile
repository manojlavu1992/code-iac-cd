SHELL := /usr/bin/env bash

# HOW TO EXECUTE
# Executing Terraform PLAN
#     $ make tf-plan env=internal
# Executing Terraform APPLY
#     $ make tf-apply env=dev
# Executing Terraform DESTROY
#     $ make tf-destroy env=dev

# Available environments: internal / staging / prod

.PHONY: help clean tf-plan tf-apply tf-destroy all-test tf-ci

.DEFAULT_GOAL := help

help:
	@echo "Usage:"
	@echo "  make <target> env=<environment>"
	@echo ""
	@echo "Targets:"
	@echo "  tf-plan     Execute Terraform plan"
	@echo "  tf-apply    Execute Terraform apply"
	@echo "  tf-destroy  Execute Terraform destroy"
	@echo "  clean       Clean up the Terraform state files"
	@echo "  all-test    Clean and then run Terraform plan"
	@echo ""
	@echo "Environments:"
	@echo "  Internal    Development/QA"
	@echo "  Staging        Staging"
	@echo "  prod        Production"

check-env:
ifndef env
	$(error env is not set)
endif

clean: check-env
	rm -rf .terraform

tf-plan: check-env clean
	terraform fmt && terraform init -backend-config=environments/$(env)/backend.tf -reconfigure && terraform validate && terraform plan -var-file=environments/$(env)/terraform.tfvars

tf-apply: check-env clean
	terraform fmt && terraform init -backend-config=environments/$(env)/backend.tf -reconfigure && terraform validate && terraform apply -var-file=environments/$(env)/terraform.tfvars -auto-approve

tf-destroy: check-env
	terraform init -backend-config=environments/$(env)/backend.tf -reconfigure && terraform destroy -var-file=environments/$(env)/terraform.tfvars

# tf-ci: check-env clean
# 	@echo "Formatting Terraform files for environment: $(env)..."
# 	terraform fmt -recursive
# 	@echo "Initializing without backend for environment: $(env)..."
# 	terraform init -backend=false -input=false
# 	@echo "Validating Terraform files for environment: $(env)..."
# 	# Temporarily moving backend config to avoid its loading during validation
# 	mv environments/$(env)/backend.tf environments/$(env)/backend.tf.bak || true
# 	terraform validate
# 	# terraform init && terraform plan -var-file=environments/$(env)/terraform.tfvars
# 	# Moving backend config back
# 	mv environments/$(env)/backend.tf.bak environments/$(env)/backend.tf || true



tf-plan-ci: check-env check-azure-creds clean
	@echo "Formatting Terraform files for environment: $(env)..."
	terraform fmt -recursive
	@echo "Initializing Terraform with backend for environment: $(env)..."
	terraform init -backend-config=environments/$(env)/backend.tf
	@echo "Planning Terraform deployment for environment: $(env)..."
	terraform plan -var-file=environments/$(env)/terraform.tfvars

check-azure-creds:
ifndef ARM_CLIENT_ID
	$(error ARM_CLIENT_ID is not set)
endif
ifndef ARM_CLIENT_SECRET
	$(error ARM_CLIENT_SECRET is not set)
endif
ifndef ARM_TENANT_ID
	$(error ARM_TENANT_ID is not set)
endif
ifndef ARM_SUBSCRIPTION_ID
	$(error ARM_SUBSCRIPTION_ID is not set)
endif




all-test: clean tf-plan
