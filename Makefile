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

tflint:
	@tflint

terraform-validate: tfsec tflint

linter:
	@golangci-lint run

gosec:
	@gosec -quiet ./...

validate: linter gosec