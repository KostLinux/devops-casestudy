variable "bitbucket_ip" {
    type    = list(string)
    default = [
        "13.52.5.0/25", "104.192.136.0/21", "185.166.140.0/22", "104.192.136.0/21", "13.52.5.96/28", "13.236.8.224/28",
        "18.184.99.224/28", "18.234.32.224/28", "18.246.31.224/28", "52.215.192.224/28", "104.192.137.240/28",
        "104.192.138.240/28", "104.192.140.240/28", "104.192.142.240/28", "104.192.143.240/28", "185.166.143.240/28",
        "185.166.142.240/28", "18.205.93.0/25", "18.234.32.128/25", "18.235.32.0/25"
    ]
}

variable "allowed_client_ip_list" {
    type    = list(string)
    default = []
}

variable "allowed_internet_ip_list" {
    type    = list(string)
    default = ["0.0.0.0/0"]
}

variable "route53_domain" {
    description = "Domain name for the ACM certificate"
    type        = string
}

variable "application_name" {
    description = "Name of the App Runner service"
    type        = string
}

variable "application_port" {
    description = "Port on which the application listens"
    type        = number
}

variable "application_environment_variables" {
    description = "Environment variables for the application"
    type        = list(object({
        name  = string
        value = string
        description = string
    }))
    default     = []
}

variable "application_repository" {
    description = "ECR repository for the application"
    type        = string
}

variable "application_image_tag" {
    description = "Tag for the application image"
    type        = string
}

variable "auto_scaling_configurations" {
    description = "Map of auto scaling configurations"
    type = map(object({
        name            = string
        min_size        = number
        max_size        = number
        max_concurrency = number
    }))
    default = {
        app_runner_autoscaler = {
        name            = "apprunner_autoscaler"
        max_concurrency = 100
        max_size        = 8
        min_size        = 1
        }
    }
}

variable "instance_configuration" {
    description = "Map of instance configuration"
    type = object({
        cpu    = number
        memory = number
    })
    default = {
        cpu    = 1024
        memory = 2048
    }
}