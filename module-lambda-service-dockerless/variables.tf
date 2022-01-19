
variable "project_name" {}

variable "environment" {}

variable "service_name" {}

variable "timeout" {
  default = 15
}

variable "runtime" {}

variable "lambda_role" {
  default = null
}

variable "vpc_subnet_ids" {
  default = []
}

variable "vpc_security_groups" {
  default = []
}
