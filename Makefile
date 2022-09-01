init:
	terraform -chdir=./lambda/ init

upgrade:
	terraform -chdir=./lambda/ init --upgrade

plan:
	terraform -chdir=./lambda/ plan -var-file=secrets.tfvars

planout:
	terraform -chdir=./lambda/ plan -out=tffile -var-file=secrets.tfvars

apply:
	terraform -chdir=./lambda/ apply -var-file=secrets.tfvars

applyout: planout
	terraform -chdir=./lambda/ apply "tffile"

apply-approve:
	terraform -chdir=./lambda/ apply -var-file=secrets.tfvars --auto-approve

destroy:
	terraform -chdir=./lambda/ destroy --auto-approve -var-file=secrets.tfvars

v:
	terraform -chdir=./lambda/ validate

f:
	terraform -chdir=./lambda/ fmt