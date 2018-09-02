resource "aws_route_table_association" "public-subnet-1a" {
  subnet_id      = "${aws_subnet.public-subnet-1a.id}"
  route_table_id = "${aws_route_table.public-routing-table.id}"
}

resource "aws_route_table_association" "public-subnet-1b" {
  subnet_id      = "${aws_subnet.public-subnet-1b.id}"
  route_table_id = "${aws_route_table.public-routing-table.id}"
}

resource "aws_route_table_association" "public-subnet-1c" {
  subnet_id      = "${aws_subnet.public-subnet-1c.id}"
  route_table_id = "${aws_route_table.public-routing-table.id}"
}

resource "aws_route_table_association" "private-subnet-1a" {
  subnet_id      = "${aws_subnet.private-subnet-1a.id}"
  route_table_id = "${aws_route_table.private-routing-table.id}"
}

resource "aws_route_table_association" "private-subnet-1b" {
  subnet_id      = "${aws_subnet.private-subnet-1b.id}"
  route_table_id = "${aws_route_table.private-routing-table.id}"
}

resource "aws_route_table_association" "private-subnet-1c" {
  subnet_id      = "${aws_subnet.private-subnet-1c.id}"
  route_table_id = "${aws_route_table.private-routing-table.id}"
}

resource "aws_main_route_table_association" "public-route-table-as" {
  vpc_id         = "${aws_vpc.main.id}"
  route_table_id = "${aws_route_table.public-routing-table.id}"
}

resource "aws_route_table" "public-routing-table" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name        = "${var.environment} Main Routing Table"
    environment = "${var.environment}"
  }
}

resource "aws_route_table" "private-routing-table" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.environment} pirvate routing table"
    environment = "${var.environment}"
  }
}
