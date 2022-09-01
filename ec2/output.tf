output "ec2_ipv4" {
  value = aws_instance.ec2_instance.public_ip
}

output "ec2_ipv4-dns" {
  value = aws_instance.ec2_instance.public_dns
}