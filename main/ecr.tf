

resource "aws_ecr_repository" "lambda_repo" {
  name                 = "${var.project_name}-${var.environment}"
  image_tag_mutability = var.image_tag_mutability
}

module "ecr_image" {
  source = "github.com/byu-oit/terraform-aws-ecr-image?ref=v1.0.1"
  dockerfile_dir = "lambda-default-image"
  ecr_repository_url = aws_ecr_repository.lambda_repo.repository_url
}