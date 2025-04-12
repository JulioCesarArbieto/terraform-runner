resource "aws_ecr_repository" "terraform_runner" {
  name = var.repo_name

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
}
