# ##############################
# EC2 Instance
# ##############################

resource "aws_instance" "nginx_server" {
  instance_type               = var.aws_ec2_type
  ami                         = var.aws_ec2_ami
  vpc_security_group_ids      = [aws_security_group.nginx_sg.id]
  subnet_id                   = aws_subnet.main_subnet_public.id
  associate_public_ip_address = true # allow public ip

  key_name = var.aws_key

  user_data_replace_on_change = true

    # # EOF method
    # # "-" is required when indentation is needed.
    # user_data = <<-EOF
    #     #!/bin/bash
    #     sudo apt update
    #     sudo apt install -y nginx
    #     echo "This is a hard coding method." >> /var/www/html/index.html
    # EOF

    # # file method
    # user_data = file("${path.module}/../ec2/install_nginx.sh")

  # templatefile method
  user_data = templatefile("${path.module}/../ec2/init.sh.tpl", {
    aws_region = var.aws_region
  })

  tags = {
    Name = "nginx_server"
  }
}

# ##############################
# Security Group
# ##############################
resource "aws_security_group" "nginx_sg" {
  name        = "Nginx Security Group"
  description = "Allow SSH and HTTP access."
  vpc_id      = aws_vpc.vpc_main.id

  # inbound: ssh
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # inbound: http
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx_sg"
  }
}
