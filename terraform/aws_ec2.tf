resource "aws_instance" "ec2_instance" {
  instance_type               = var.aws_ec2_type
  ami                         = var.aws_ec2_ami
  vpc_security_group_ids      = [aws_security_group.sg_ssh.id]
  subnet_id                   = aws_subnet.subnet_public.id
  associate_public_ip_address = true

  key_name = var.aws_key

  tags = {
    Name = "ec2-instance"
  }
}

resource "aws_security_group" "sg_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH access"
  vpc_id      = aws_vpc.vpc_main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this for better security in real deployments
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}
