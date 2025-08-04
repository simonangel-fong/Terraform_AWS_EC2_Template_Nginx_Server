variable "aws_region" {
  type        = string
  description = "aws region"
}

variable "aws_ec2_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "aws_ec2_ami" {
  type        = string
  description = "EC2 instance image"
}

variable "aws_key" {
  description = "SSH Key Pair name"
}