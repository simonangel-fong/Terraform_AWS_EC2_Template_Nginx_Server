resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Main VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "Main IGW"
  }
}

# Public Subnet
resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_main.id
  availability_zone       = "ca-central-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Ensure instances get public IPs

  tags = {
    Name = "Main public subnet"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "rta_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rt_public.id
}
