# Alpeso Recruiting - SENIOR DEVOPS ENGINEER

This is a test project within Alpeso's technical recruiting process.

Look at the following tasks and estimate how much time you will spend on them.

In doubt of technical issues you can send an e-mail with your questions.

## Preconditions

### Technical & Knowledge
You need at least:

* Experience with AWS stack
* Experience with CI/CD
* Experience with Bash scripts
* Experience in at least one programming language (Java, Python, PHP, Perl, etc.)
* A text editor of your choice

## The tasks
1) We have a Terraform securitygroups.tf file. Every time Terraform runs, it says the security group in that file will be updated in place. Find a way to prevent this.  

2) You have the alpeso-test.tar.gz archive. What we can improve?
    
3) Provide infrastructure and create CI/CD with a web app that will listen to 8089 port and return "ReallyNotBad" string when POST request contains header "NotBad" with value "true", eg. `curl -X POST -H "NotBad: true" https://someurl:8089/` should return "ReallyNotBad".
Use any technology you want to deploy the application to AWS. It can be Ansible, Terraform, etc. or a combination of some of them.
Hint: https://aws.amazon.com/free/

## Getting started

**1. Clone this repository**

```bash
git clone git@github.com:KostLinux/devops-casestudy.git
```

**2. Configure environment variables**

APP_ENV can be `development` or `production`. If APP_ENV is set to development, then it will show debug logs from Gin framework.

```
cp .env.example .env

# App
# APP_ENV development | production
APP_ENV=development
APP_HOST=localhost
APP_PORT=8089

# AWS Credentials
AWS_ACCESS_KEY_ID="AWS_ACCESS_KEY"
AWS_SECRET_ACCESS_KEY="AWS_SECRET_KEY"
```

**3. Create prerequisites via [Cloudformation Template](cloudformation/prerequisites.yml) in AWS**

```bash
aws cloudformation create-stack --stack-name "AppRunnerPrerequisites" --template-body file://cloudformation/prerequisites.yml --parameters ParameterKey=BucketName,ParameterValue=alpeso-s3-bucket ParameterKey=RepositoryName,ParameterValue=golang-web-application
```

**4. Configure terraform in terraform/ directory**

Use your favorite code editor to edit `terraform/main.tf`, `terraform/provider.tf`, and `terraform/versions.tf` files.

Under versions.tf file you need to change the bucket name to bucket name which you created in step 3.

**Note** Due to Remote TFState Backend, prerequisites must be configured! (Step 3)

**5. Configure Github secrets**

Create a new repository in Github and add the following secrets:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- ECR_REPOSITORY_NAME e.g golang-web-application

**5. Write some code and run the application**

```bash
code .
make run
```

If you want to deploy to AWS, make sure your application works via Dockerfile

```bash
make build
make run-docker
```

**6. Deploy infrastructure**

```bash
make apply
```

**7. Commit changes**

```bash
git commit -a -m "feat: Added some api endpoint"
git push origin main
```

## Comments from Author

1. I refactored alpeso-test keycloak script and packed it as alpeso-test.tar.gz, the old one is under .bkup
2. I have created a simple web application using Golang and Gin framework. The application listens on port 8089 and returns "ReallyNotBad" when POST request contains header "NotBad" with value "true".
3. I have created a Cloudformation template to create prerequisites to run the terraform
4. I have create a simple Github Actions workflow, in ideal world it should:
    - 4.1 Run terraform tests when changes pushed to feature branch
    - 4.2 Use Github environments for terraform apply
    - 4.3 If github environment is `production` then apply should be done manually or via Git tag (if no github license)
    - 4.4 If github environment is `development / QA` then apply should be done automatically
5. I cannot test the AWS App Runner terraform, cause domain is paid and I don't have any free domain to test it.
6. I could use AWS generated domain, but even then, AWS App Runner doesn't have any free tier, so I cannot test it without costs.
7. The AWS App Runner is one of the easiest way of deploying simple web applications to AWS