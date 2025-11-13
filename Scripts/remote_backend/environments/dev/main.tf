resource "aws_instance" "dev-server" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  region        = var.my-ec2-region
  tags = {
    Name        = "Dev-Server"
    Environment = var.environment
  }
}