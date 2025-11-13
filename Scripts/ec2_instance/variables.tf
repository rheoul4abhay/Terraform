variable "ec2_instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ec2_root_storage_size" {
  default = 10
  type    = number
}

variable "ec2_ami_id" {
  default = "ami-0ecb62995f68bb549"
  type    = string
}

variable "ec2_storage_volume_type" {
  default = "gp3"
  type    = string
}

variable "ec2_instance_count" {
  default = 3
  type    = number
}

variable "environment" {
  default = "dev"
  type    = string
}