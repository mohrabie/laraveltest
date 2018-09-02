resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.environment} Internet Gateway"
    environment = "${var.environment}"
  }
}
