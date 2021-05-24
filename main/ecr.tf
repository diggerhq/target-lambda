

resource "aws_ecr_repository" "default_repo" {
  name                 = "${var.project_name}-${var.environment}"
  image_tag_mutability = var.image_tag_mutability
}

