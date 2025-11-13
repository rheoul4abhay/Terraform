# Set provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# key pair login
resource "aws_key_pair" "my-ec2-key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}

# VPC & security group

# VPC
resource "aws_default_vpc" "default" {

}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "Automate Security Group"
  description = "This will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id # Interpolation: It is a way in which you can extract/inherit values from a Terraform block

  # Optional tags
  tags = {
    Name = "Automate-SG"
  }

  # Inbound rules for the security group
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Open"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "My App"
  }

  # Outbound rules for the security group
  egress {
    from_port   = 0    # Port as 0 means all ports
    to_port     = 0    # From and to port fields are optional for outbound rules
    protocol    = "-1" # Symatically -1 equal to all ports
    cidr_blocks = ["0.0.0.0/0"]
    description = "All access open outbound"
  }
}

# EC2 instance
resource "aws_instance" "my-ec2" {

  for_each = tomap({
    My-EC2-micro  = "t2.micro"
    My-EC2-medium = "t2.medium"
  })

  # One of the use case of using depends_on like below includes using it for running a script has s3 bucket path set, but if the s3 bucket is not available or set at the time of running this script then the script will fail, hence to make sure that the s3 bucket is ready by the time we want to run this script, we use this meta argument

  depends_on = [aws_key_pair.my-ec2-key, aws_security_group.my_security_group]

  key_name        = aws_key_pair.my-ec2-key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = each.value # Setting value from for_each meta argument
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size = var.environment == "prod" ? 20 : var.ec2_root_storage_size
    volume_type = var.ec2_storage_volume_type
  }
  tags = {
    Name = each.key
  }
}

# Adding another instance which we want to be imported and referenced to an already existing aws instance

/*
resource "aws_instance" "my_new_instance" {
  ami = "unknown"
  instance_type = "unknown"
}
*/