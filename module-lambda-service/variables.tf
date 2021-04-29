
variable "project_name" {}

variable "environment" {}

variable "service_name" {}

variable "ecr_repo" {}

variable "api_gateway" {}

variable "image_uri" {
  default = "public.ecr.aws/t4q6p9j7/dg-lambda-default:latest"
}

variable "dockerfile_command" {
  default = tolist(["app.handler"])
}
