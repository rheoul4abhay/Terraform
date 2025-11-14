# key pair login
resource "aws_key_pair" "my-ec2-key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("terra-key.pub")

  tags = {
    Environment = var.env
  }
}

# VPC & security group

# VPC
resource "aws_default_vpc" "default" {

}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-infra-app-sg"
  description = "This will add a TF generated security group"
  vpc_id      = aws_default_vpc.default.id # Interpolation: It is a way in which you can extract/inherit values from a Terraform block

  # Optional tags
  tags = {
    Name = "${var.env}-infra-app-sg"
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

  count = var.ec2_instance_count

  # One of the use case of using depends_on like below includes using it for running a script has s3 bucket path set, but if the s3 bucket is not available or set at the time of running this script then the script will fail, hence to make sure that the s3 bucket is ready by the time we want to run this script, we use this meta argument

  depends_on = [aws_key_pair.my-ec2-key, aws_security_group.my_security_group]

  key_name        = aws_key_pair.my-ec2-key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = var.ec2_instance_type
  ami             = var.ec2_ami_id
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prod" ? 20 : 10
    volume_type = "gp3"
  }
  tags = {
    Name        = "${var.env}-infra-app-instance"
    Environment = var.env
  }
}