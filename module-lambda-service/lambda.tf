
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
  image_uri     = var.ecr_repo.repository_url
  function_name = var.service_name
  role          = aws_iam_role.iam_for_lambda.arn

  # docker options
  # image_config {
  #   command           = var.dockerfile_command
  #   entrypoint        = var.dockerfile_entrypoint
  #   working_directory = var.dockerfile_working_directory
  # }

  runtime = "python3.8"
}
