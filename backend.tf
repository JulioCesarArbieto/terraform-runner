terraform {
  backend "s3" {
    bucket         = "terraform-runner-state"
    key            = "env:/terraform.tfstate"
    region         = "us-east-2"  # <- Esta es la región donde está tu bucket
    encrypt        = true
    dynamodb_table = "terraform-locks" # si estás usando locking
  }
}