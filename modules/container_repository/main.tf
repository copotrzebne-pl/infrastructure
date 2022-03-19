resource "aws_ecr_repository" "container_repository" {
  name                 = var.name
  image_tag_mutability = "IMMUTABLE"

  #checkov:skip=CKV_AWS_163: ECR image scanning is disabled to save the money
  image_scanning_configuration {
    scan_on_push = false
  }

  #checkov:skip=CKV_AWS_136: ECR repository is encrypted using AES256 to save the money
  encryption_configuration {
    encryption_type = "AES256"
  }
}
