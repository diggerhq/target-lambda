
variable "project_name" {}

variable "environment" {}

variable "service_name" {}

variable "ecr_repo" {}

variable "api_gateway" {}

variable "image_uri" {
  default = "public.ecr.aws/t4q6p9j7/dg-lambda-default:latest"
}

variable "lambda_role" {
  default = null
}

variable "vpc_subnet_ids" {
  default = []
}

variable "vpc_security_groups" {
  default = []
}

variable "dockerfile_command" {
  default = ["app.handler"]
}
