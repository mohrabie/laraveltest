resource "aws_autoscaling_group" "microservices-as" {
  name                      = "microservices-${var.environment}"
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.microservices_as_conf.name}"
  vpc_zone_identifier       = ["${data.aws_subnet_ids.public-subnets.ids}"]

  tag {
    key                 = "environment"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "MS ${var.environment}"
    propagate_at_launch = true
  }
}
