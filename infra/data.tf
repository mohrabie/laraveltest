data "aws_availability_zones" "available" {}

data "aws_subnet_ids" "private-subnets" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    public = "false"
  }
}

data "aws_subnet_ids" "public-subnets" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    public = "true"
  }
}

data "aws_ami" "ecs-instance" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-2018.03.e-amazon-ecs-optimized"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
