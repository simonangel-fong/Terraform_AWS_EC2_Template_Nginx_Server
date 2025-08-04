output "aws_instance_public_ip" {
  value = "http://${aws_instance.nginx_server.public_ip}"
}

output "aws_instance_ssh" {
  value = "ssh -i ${var.aws_key}.pem ubuntu@${aws_instance.nginx_server.public_ip}"
}
