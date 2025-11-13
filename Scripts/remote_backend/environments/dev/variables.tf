variable "environment" {
  default = "dev"
}

variable "my-ec2-region" {
  default = "us-east-1"
}

variable "ec2_ami_id" {
  default = "ami-0ecb62995f68bb549"
  type    = string
}

variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}