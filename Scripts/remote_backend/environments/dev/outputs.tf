output "aws_ec2_public_ip" {
  value = aws_instance.dev-server.public_ip
}

output "aws_ec2_private_ip" {
  value = aws_instance.dev-server.private_ip
}
output "aws_ec2_public_dns" {
  value = aws_instance.dev-server.public_dns
}

output "aws_ec2_private_dns" {
  value = aws_instance.dev-server.private_dns
}