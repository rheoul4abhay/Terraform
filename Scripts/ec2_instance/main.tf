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
  key_name        = aws_key_pair.my-ec2-key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = var.ec2_instance_type
  ami             = var.ec2_ami_id
  count           = var.ec2_instance_count
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = var.ec2_storage_volume_type
  }
  tags = {
    Name = "Terraform-automate"
  }
}