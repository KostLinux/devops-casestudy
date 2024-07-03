_DEFAULT_GOAL := run

run:
	go run main.go

init:
	@source .env \
    && terraform init -upgrade -reconfigure

format:
	@terraform fmt -recursive
	
plan:
	@source .env \
    init \
	&& terraform plan

apply: 
	@source .env \
	plan \
	&& terraform apply -auto-approve

tfsec:
	@tfsec

lint:
	@tflint

validate: tfsec lint