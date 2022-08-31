init:
	terraform -chdir=./ec2/ init

plan:
	terraform -chdir=./ec2/ plan -var-file=secrets.tfvars

planout:
	terraform -chdir=./ec2/ plan -out=tffile -var-file=secrets.tfvars

apply:
	terraform -chdir=./ec2/ apply -var-file=secrets.tfvars

applyout: planout
	terraform -chdir=./ec2/ apply "tffile"

apply-approve:
	terraform -chdir=./ec2/ apply -var-file=secrets.tfvars --auto-approve

destroy:
	terraform -chdir=./ec2/ destroy --auto-approve -var-file=secrets.tfvars

v:
	terraform -chdir=./ec2/ validate

f:
	terraform -chdir=./ec2/ fmt