variable "env" {
  description = "This is the environment for my infra"
  type        = string
}

variable "bucket_name" {
  description = "This is the bucket name for my infra"
  type        = string
}

variable "dynamodb_table_name" {
  description = "This is the dynamodb table name for my infra"
  type        = string
}

variable "hash_key" {
  description = "This is the hash key for the dynamo db table"
  type        = string
}

# EC2 Instance Variables
variable "ec2_instance_type" {
  description = "This is the instance type"
  type        = string
}

variable "ec2_ami_id" {
  description = "This is the instance ami id of the instance"
  type        = string
}

variable "ec2_instance_count" {
  description = "This is the number of ec2 instances"
  type        = number
}