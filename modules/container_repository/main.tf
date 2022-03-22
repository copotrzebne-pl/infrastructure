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

resource "aws_ecr_lifecycle_policy" "keep" {
  repository = aws_ecr_repository.container_repository.name

  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Keep last 2 images",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["v"],
          "countType" : "imageCountMoreThan",
          "countNumber" : 2
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}

resource "aws_ecr_lifecycle_policy" "expire" {
  repository = aws_ecr_repository.container_repository.name

  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 2,
        "description" : "Expire images older than 1 days",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 1
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}
