resource "aws_vpc" "tsuchida-vpc" {
  cidr_block = "10.100.0.0/16"
  tags = {
    Name = "${var.PROJECT}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tsuchida-vpc.id
  tags = {
    Name = "${var.PROJECT}-igw"
  }
}

resource "aws_subnet" "tsuchida-subnet-a" {
  vpc_id            = aws_vpc.tsuchida-vpc.id
  cidr_block        = "10.100.1.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "${var.PROJECT}-subnet-a"
  }
}

resource "aws_subnet" "tsuchida-subnet-c" {
  vpc_id            = aws_vpc.tsuchida-vpc.id
  cidr_block        = "10.100.11.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "${var.PROJECT}-subnet-c"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.tsuchida-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.PROJECT}-route-igw"
  }
}

resource "aws_route_table_association" "route-a" {
  subnet_id      = aws_subnet.tsuchida-subnet-a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "route-c" {
  subnet_id      = aws_subnet.tsuchida-subnet-c.id
  route_table_id = aws_route_table.public-route-table.id
}
