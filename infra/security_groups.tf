resource "aws_security_group" "elb-security_group" {
  vpc_id      = "${aws_vpc.main.id}"
  description = "AWS SG to be attached to any ELB accessing MS, this only to controls access the the ECS instances not the services itself, each MS will be able to control what can access it publically using its own SG"

  tags {
    Name        = "${var.environment}-ELB-MS-SG"
    environment = "${var.environment}"
    role        = "access"
    type        = "elb"
  }
}

resource "aws_security_group" "ecs-instance-security_group" {
  vpc_id      = "${aws_vpc.main.id}"
  description = "AWS SG to be attached to any ecs instance running in an ECS cluster to allow connections from an LB to the dynamically allocated ports, this value equals to  /proc/sys/net/ipv4/ip_local_port_range"

  ingress {
    from_port       = 32768
    to_port         = 60999
    protocol        = "tcp"
    security_groups = ["${aws_security_group.elb-security_group.id}"]
    description     = "Secure public"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.environment}-ECS-SG"
    environment = "${var.environment}"
  }
}

resource "aws_security_group" "public-web-security_group" {
  vpc_id      = "${aws_vpc.main.id}"
  description = "Allow all http/https traffic from anywhere"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Insecure public"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Secure public"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh-security_group" {
  vpc_id      = "${aws_vpc.main.id}"
  name        = "${var.environment} ssh-security_group"
  description = "Control SSH Access to resources"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private-mongodb-security_group" {
  name        = "${var.environment} mongodb-security_group"
  description = "mongodb private security group"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    self            = true
    security_groups = ["${aws_security_group.access-to-database-security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "Mongodb Database"
    environment = "${var.environment}"
  }
}

resource "aws_security_group" "access-to-database-security_group" {
  name        = "private-database-access-security_group"
  description = "Allow any resource in this vpc to connect to the environment database"
  vpc_id      = "${aws_vpc.main.id}"

  tags {
    Name        = "Database Access"
    environment = "${var.environment}"
    role        = "access"
  }
}

resource "aws_security_group_rule" "access-to-ms-rules" {
  type                     = "egress"
  from_port                = 32768
  to_port                  = 60999
  protocol                 = "tcp"
  source_security_group_id = "${aws_security_group.ecs-instance-security_group.id}"
  security_group_id        = "${aws_security_group.elb-security_group.id}"
}
