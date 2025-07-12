# Create VPC using the provided CIDR block and DNS settings
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "userdata-vpc"
  }
}

#Declaring data source
data "aws_availability_zones" "available" {
  state = "available"
}

#creates two public subnets within a single resource block
resource "aws_subnet" "public_subnet" {
  count = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.subnet_cidrs, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index}"
  }
}

#creates two private subnets within a single resource block
resource "aws_subnet" "private_subnet" {
  count = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = false # Private subnets do not assign public IPs
  tags = {
    Name = "private-subnet-${count.index}"
  }
}


# Create an Internet Gateway
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main-igw"
  }
}

# Create Route Table for Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}



# Associate the Public Subnet with the Route Table
resource "aws_route_table_association" "public_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "private_subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}



# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}


# NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "alb-nat-gw"
  }
}


# Private Route Table for NAT Gateway 
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "private-route-table"
  }
}

# Associate the private subnet with the private route table
resource "aws_route_table_association" "private_route_table_association" {
  subnet_id      = aws_subnet.private_subnet[0].id
  route_table_id = aws_route_table.private_route_table.id
}
