terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }
}

provider "aws" {
  region = var.my-ec2-region
}

resource "aws_s3_bucket" "state-lock-bucket" {
  bucket = "state-lock-bucket-ft.abhay"
  region = var.my-ec2-region
}

resource "aws_s3_bucket_versioning" "state-lock-bucket-versioning" {
  bucket = aws_s3_bucket.state-lock-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "state-lock-table" {
  depends_on   = [aws_s3_bucket.state-lock-bucket]
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S" # S is short for string
  }
}