
# resource "aws_api_gateway_resource" "proxy" {
#   rest_api_id = var.api_gateway.id
#   parent_id   = var.api_gateway.root_resource_id
#   path_part   = "{proxy+}"
# }

# resource "aws_api_gateway_method" "proxy" {
#   rest_api_id   = var.api_gateway.id
#   resource_id   = aws_api_gateway_resource.proxy.id
#   http_method   = "ANY"
#   authorization = "NONE"
# }
