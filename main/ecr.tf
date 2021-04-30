

resource "aws_ecr_repository" "lambda_repo" {
  name                 = "${var.project_name}-${var.environment}"
  image_tag_mutability = var.image_tag_mutability
}

module "ecr_image" {
  source = "../module-aws-ecr-image"
  dockerfile_dir = "lambda-default-image"
  ecr_repository_url = aws_ecr_repository.lambda_repo.repository_url
}