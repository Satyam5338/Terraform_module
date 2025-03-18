# VPC Module
resource "aws_vpc" "sp_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "sp-vpc"
  }
}

resource "aws_internet_gateway" "sp_igw" {
  vpc_id = aws_vpc.sp_vpc.id
  tags = {
    Name = "sp-igw"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "sp_rt" {
  vpc_id = aws_vpc.sp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sp_igw.id
  }

  tags = {
    Name = "sp-public-rt"
  }
}

# Associate Subnet with Public Route Table
resource "aws_route_table_association" "sp_rta" {
  subnet_id      = aws_subnet.sp_subnet.id
  route_table_id = aws_route_table.sp_rt.id
}

resource "aws_subnet" "sp_subnet" {
  vpc_id                  = aws_vpc.sp_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "sp-subnet"
  }
}

output "vpc_id" {
  value = aws_vpc.sp_vpc.id
}

output "subnet_id" {
  value = aws_subnet.sp_subnet.id
}

variable "vpc_cidr" {}
variable "subnet_cidr" {}
