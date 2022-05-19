
resource "aws_api_gateway_rest_api" "main" {
  name = "${var.project_name}-${var.environment}"
}

