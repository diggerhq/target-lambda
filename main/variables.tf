
variable "iam_user" {}

variable "aws_key" {}

variable "aws_secret" {}

variable "project_name" {}

variable "environment" {}

variable "region" {}

# The tag mutability setting for the repository
variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "The tag mutability setting for the repository (defaults to IMMUTABLE)"
}

variable "image_uri" {
  
}
