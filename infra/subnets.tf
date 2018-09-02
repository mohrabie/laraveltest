resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name        = "${var.environment}-public-1a_10.2.1.0"
    public      = "true"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "public-subnet-1b" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.2.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name        = "${var.environment}-public-1b_10.2.2.0"
    public      = "true"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "public-subnet-1c" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.2.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

  tags {
    Name        = "${var.environment}-public-1c_10.2.3.0"
    public      = "true"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnet-1a" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.2.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[0]}"

  tags {
    Name        = "${var.environment}-private-1a_10.2.4.0"
    public      = "false"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnet-1b" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.2.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[1]}"

  tags {
    Name        = "${var.environment}-private-1b_10.2.5.0"
    public      = "false"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnet-1c" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.2.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "${data.aws_availability_zones.available.names[2]}"

  tags {
    Name        = "${var.environment}-private-1c_10.2.6.0"
    public      = "false"
    environment = "${var.environment}"
  }
}
