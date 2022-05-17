
resource "aws_apigatewayv2_api" "api" {
  name          = "${var.lambda_function_name}-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "apigateway_stage" {
  api_id = aws_apigatewayv2_api.api.id

  name        = "${var.lambda_function_name}-stage"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gw.arn

    format = jsonencode({
      requestId               = "$context.requestId"
      sourceIp                = "$context.identity.sourceIp"
      requestTime             = "$context.requestTime"
      protocol                = "$context.protocol"
      httpMethod              = "$context.httpMethod"
      resourcePath            = "$context.resourcePath"
      routeKey                = "$context.routeKey"
      status                  = "$context.status"
      responseLength          = "$context.responseLength"
      integrationErrorMessage = "$context.integrationErrorMessage"
      }
    )
  }
}

resource "aws_apigatewayv2_integration" "apigateway_integration" {
  api_id = aws_apigatewayv2_api.api.id

  integration_uri    = var.lambda_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "apigateway_route" {
  api_id = aws_apigatewayv2_api.api.id

  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.apigateway_integration.id}"
}

resource "aws_cloudwatch_log_group" "api_gw" {
  name = "/aws/api_gw/${aws_apigatewayv2_api.api.name}"

  retention_in_days = var.logs_retention_in_days
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}