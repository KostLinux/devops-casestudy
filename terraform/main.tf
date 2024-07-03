module "aws_app_runner" {
    source = "./modules/aws-app-runner"

    application_name = "GolangWebApp"
    application_port = 8089
    application_environment_variables = [
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

    route53_domain = "example.com"
    application_repository = "golang-web-app"
    application_image_tag = "latest"
}