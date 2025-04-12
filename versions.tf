# versions.tf
provider "aws" {
  region = var.aws_region
  version = "~> 4.0" # Asegúrate de que sea una versión compatible
}