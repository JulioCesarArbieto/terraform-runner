resource "aws_s3_bucket" "tf_backend" {
  #provider      = aws.us_east_2
  bucket        = "terraform-runner-state"
  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = false
    ignore_changes  = all
  }

  tags = {
    Name        = "terraform-backend"
    Environment = "Dev"
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  #provider      = aws.us_east_2
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "terraform-locks"
    Environment = "Dev"
  }
}