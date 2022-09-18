resource "aws_ecr_repository" "repo" {
  name                 = var.erc_repo_name
  image_tag_mutability = var.tag_mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = var.encryption_type
  }
  tags = {
    Name = var.erc_repo_name
    Billing = var.erc_repo_name
  }
}

resource "aws_ecr_lifecycle_policy" "repo_policy" {
  repository = aws_ecr_repository.repo.name

  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Keep last 30 images",
        "selection" : {
          "tagStatus" : "tagged",
          "tagPrefixList" : ["v"],
          "countType" : "imageCountMoreThan",
          "countNumber" : 30
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })
}