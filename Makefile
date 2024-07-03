_DEFAULT_GOAL := run

run:
	go run main.go

build:
	docker build -t alpeso-web:dev .

run-docker:
	docker run --env-file ./.env -p 8089:8089 alpeso-web:dev

init:
	@cd terraform \
	source .env \
    && terraform init -upgrade -reconfigure

format:
	@terraform fmt -recursive
	
plan:
	@cd terraform \
	source .env \
    && terraform init -upgrade -reconfigure \
	&& terraform plan

apply: 
	@cd terraform \
	source .env \
    && terraform init -upgrade -reconfigure \
	&& terraform plan \
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