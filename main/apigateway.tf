
resource "aws_apigatewayv2_api" "main" {
  name                       = "${var.project_name}-${var.environment}"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}
