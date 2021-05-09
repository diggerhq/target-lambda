
resource "aws_iam_role" "iam_for_lambda" {
  name_prefix = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  image_uri     = var.image_uri
  # image_uri     = "quay.io/turner/turner-defaultbackend:0.2.0"
  function_name = local.function_name
  role          = var.lambda_role == null ? aws_iam_role.iam_for_lambda.arn : var.lambda_role
  package_type  = "Image"

  # docker options
  image_config {
    command           = var.dockerfile_command
    # entrypoint        = var.dockerfile_entrypoint
    # working_directory = var.dockerfile_working_directory
  }

  vpc_config {
    subnet_ids = ["subnet-dfe24085", "subnet-4bbedf2d"]
    security_group_ids = ["sg-7e8d370e"] 
  }
  # dynamic "vpc_config" {
  #   for_each = var.vpc_config == null ? [] : list(var.vpc_config)
  #   content {
  #     subnet_ids = vpc_config.value["vpc_subnet_ids"]
  #     security_group_ids = vpc_config.value["vpc_security_group_ids"]
  #   }
  # }
  # runtime = "python3.8"
}
