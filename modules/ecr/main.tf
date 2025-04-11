resource "aws_ecr_repository" "terraform_runner" {
  name = "terraform-runner"
}

output "repository_url" {
  value = aws_ecr_repository.terraform_runner.repository_url
}