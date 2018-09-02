data "template_file" "user_data" {
  template = "${file("bootstrap.tpl")}"

  vars {
    cluster_id = "microservices-${var.environment}"
  }
}

resource "aws_launch_configuration" "microservices_as_conf" {
  name_prefix          = "microservices-${var.environment}_config"
  image_id             = "${data.aws_ami.ecs-instance.id}"
  instance_type        = "t3.micro"
  user_data            = "${data.template_file.user_data.rendered}"
  key_name             = "terraform"
  iam_instance_profile = "ecsInstanceRole"
  security_groups      = ["${aws_security_group.ecs-instance-security_group.id}", "${aws_security_group.ssh-security_group.id}", "${aws_security_group.access-to-database-security_group.id}"]

  lifecycle {
    create_before_destroy = true
  }
}
