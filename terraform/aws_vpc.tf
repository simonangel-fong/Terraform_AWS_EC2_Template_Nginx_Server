# ##############################
# VPC
# ##############################

resource "aws_vpc" "vpc_main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc_main"
  }
}

# ##############################
# Subnet
# ##############################

resource "aws_subnet" "main_subnet_public" {
  vpc_id                  = aws_vpc.vpc_main.id
  availability_zone       = "ca-central-1a"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true # Ensure instances get public IPs

  tags = {
    Name = "main_subnet_public"
  }
}

# ##############################
# Internet Gateway
# ##############################
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "main_igw"
  }
}

# ##############################
# Route Table
# ##############################
resource "aws_route_table" "main_rt_public" {
  vpc_id = aws_vpc.vpc_main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "main_rt_public"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "rta_public" {
  subnet_id      = aws_subnet.main_subnet_public.id
  route_table_id = aws_route_table.main_rt_public.id
}
