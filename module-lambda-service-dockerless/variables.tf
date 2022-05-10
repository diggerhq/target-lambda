variable "lambda_function_name" {}

variable "project_name" {}

variable "environment" {}

variable "service_name" {}

variable "timeout" {
  default = 15
}

variable "memory_size" {
  default = 128
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
