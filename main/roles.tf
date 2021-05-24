
resource "aws_iam_role" "default_iam_for_lambda" {
  name_prefix = "${var.project_name}-${var.environment}-lambda-role"

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

data "aws_iam_policy_document" "dynamodb" {
    version = "2012-10-17"
    statement {
      sid = "AllowLimitedSSMParamstoreAccess"
      actions = [
        "dynamodb:GetItem",
        "dynamodb:DeleteItem",
        "dynamodb:PutItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:UpdateItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:BatchGetItem",
        "dynamodb:DescribeTable",
        "dynamodb:ConditionCheckItem"
      ]
      effect = "Allow"
      resources = [
          "*"
      ]
  }
}

resource "aws_iam_policy" "dynamodb" {
    name   = "${var.project_name}-${var.environment}-dynamodb"
    policy = data.aws_iam_policy_document.dynamodb.json
}

data "aws_iam_policy_document" "gw_connections" {
    version = "2012-10-17"
    statement {
      sid = "ManageGatewayConnections"
      actions = [
        "execute-api:ManageConnections"
      ]
      effect = "Allow"
      resources = [
          aws_apigatewayv2_api.main.arn
      ]
  }
}

resource "aws_iam_role_policy_attachment" "gateway_connections" {
    role       = aws_iam_role.default_iam_for_lambda.name
    policy_arn = aws_iam_policy.gw_connections.arn
}


resource "aws_iam_role_policy_attachment" "ssm_params" {
    role       = aws_iam_role.default_iam_for_lambda.name
    policy_arn = aws_iam_policy.dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role" {
  role       = aws_iam_role.default_iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
