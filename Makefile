#Makefile
ifdef OS
   BLAT = $(powershell  -noprofile rm .\.terraform\ -force -recurse)
else
   ifeq ($(shell uname), Linux)
      RM  = rm .terraform/modules/ -fr
      BLAT= rm .terraform/ -fr
   endif
endif

.PHONY: all

all: init plan build

init:
	$(RM)
	terraform init -reconfigure

plan:
	terraform plan --out tfplan.binary -refresh=true

p:
	terraform plan -refresh=true

apply: build

build:
	terraform apply -auto-approve

convert:
	terraform show -json tfplan.binary > tfplan.json

check: init
	terraform plan -detailed-exitcode

destroy: init
	terraform destroy -force

docs:
	terraform-docs md . > README.md

valid:
	terraform fmt -check=true -diff=true
	checkov -d . --external-checks-dir ../../checkov

conftest: init plan convert
	conftest test ./tfplan.json -p ./policies


target:
	@read -p "Enter Module to target:" MODULE;
	terraform apply -target $$MODULE

purge:
	$(BLAT)
