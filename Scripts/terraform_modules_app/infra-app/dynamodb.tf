resource "aws_dynamodb_table" "my-dynamodb-table" {
  name = "${var.env}-${var.dynamodb_table_name}"
  tags = {
    Name        = "${var.env}-infra-app-table"
    Environment = var.env
  }
  depends_on   = [aws_s3_bucket.tf-app-s3]
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key
  attribute {
    name = var.hash_key
    type = "S"
  }
}