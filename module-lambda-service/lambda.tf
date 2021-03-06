

resource "aws_lambda_function" "test_lambda" {
  image_uri     = var.image_uri
  # image_uri     = "quay.io/turner/turner-defaultbackend:0.2.0"
  function_name = local.function_name
  role          = var.lambda_role
  package_type  = "Image"
  timeout       = var.timeout
  memory_size   = var.memory_size

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

  lifecycle {
    ignore_changes = [
      image_uri,
      image_config,
      environment
    ]
  }
}

# gateway permission
resource "aws_lambda_permission" "lambda_permission" {
  count = var.api_gateway == null ? 0 : 1
  statement_id  = "${var.project_name}${var.environment}${var.service_name}APIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn = "${var.api_gateway.execution_arn}/*/*/*"
}

output "lambda_arn" {
  value = aws_lambda_function.test_lambda.arn
}

output "function_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.test_lambda.invoke_arn
}
