terraform {
  backend "s3" {
    bucket         = "terraform-runner-state"
    key            = "runner/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}