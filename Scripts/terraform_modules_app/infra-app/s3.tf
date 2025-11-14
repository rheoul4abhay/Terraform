resource "aws_s3_bucket" "tf-app-s3" {
  bucket = "${var.env}-${var.bucket_name}"
  tags = {
    Name        = "${var.env}-infra-app-s3"
    Environment = var.env
  }
}