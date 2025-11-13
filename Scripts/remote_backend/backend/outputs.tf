output "s3_bucket_name" {
  value = aws_s3_bucket.state-lock-bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.state-lock-table.name
}