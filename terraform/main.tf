module "aws_app_runner" {
    source = "./modules/aws-app-runner"

    // application_name + route53_domain will be domain for AWS App Runner
    application_name = "golang-web-app"
    application_port = 8089
    route53_domain = "example.com"

    application_environment_variables = [
        {
            name  = "APP_ENV"
            value = "production"
            description = "Environment in which the application runs"
        },
        {
            name  = "APP_HOST"
            value = "golang-web-app.example.com"
            description = "Log level for the application"
        },
        {
            name  = "APP_PORT"
            value = "8089"
            description = "Port on which the application listens"
        }
    ]

    allowed_client_ip_list = [
        "213.35.170.12/32"
    ]
    
    allowed_internet_ip_list = [
        "0.0.0.0/0"
    ]

    application_repository = "golang-web-app"
    application_image_tag = "latest"
}