

resource "aws_lambda_function" "test_lambda" {
  image_uri     = var.image_uri
  # image_uri     = "quay.io/turner/turner-defaultbackend:0.2.0"
  function_name = local.function_name
  role          = var.lambda_role
  package_type  = "Image"
  timeout       = 15
  # docker options
  image_config {
    command           = var.dockerfile_command
    # entrypoint        = var.dockerfile_entrypoint
    # working_directory = var.dockerfile_working_directory
  }

  vpc_config {
    subnet_ids = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_groups
  }
}

output "lambda_arn" {
  value = aws_lambda_function.test_lambda.arn
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.test_lambda.invoke_arn
}
