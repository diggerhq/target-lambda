
resource "aws_lambda_function" "lambda" {
  image_uri     = var.image_uri
  function_name = local.function_name
  role          = var.lambda_role
  package_type  = "Zip"
  timeout       = var.timeout
  runtime       = var.runtime

  vpc_config {
    subnet_ids = var.vpc_subnet_ids
    security_group_ids = var.vpc_security_groups
  }

  lifecycle {
    ignore_changes = [
      environment
    ]
  }
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "function_name" {
  value = aws_lambda_function.lambda.function_name
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.lambda.invoke_arn
}
