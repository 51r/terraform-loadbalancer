resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name  = "${var.name}-vpc"
    email = var.email
  }
}

resource "aws_internet_gateway" "public_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${var.name}-internet-gateway"
    email = var.email
  }
}

resource "aws_nat_gateway" "private_gateway" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.name}-private-gateway"
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name}-public-subnet${count.index + 1}"
    email = var.email
  }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "${var.name}-private-subnet-${count.index + 1}"
  }
}

resource "aws_eip" "nat1" {
  depends_on = [
    aws_internet_gateway.public_gateway
  ]

  tags = {
    "Name" = "${var.name}-eip"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_gateway.id
  }

  tags = {
    Name  = "${var.name}-private-route-table"
    email = var.email
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_gateway.id
  }

  tags = {
    Name  = "${var.name}-public-route-table"
    email = var.email
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}


output "aws_vpc" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}