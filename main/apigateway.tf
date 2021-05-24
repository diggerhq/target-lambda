
resource "aws_apigatewayv2_api" "example" {
  name                       = "${var.project_name}-${var.environment}"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}
