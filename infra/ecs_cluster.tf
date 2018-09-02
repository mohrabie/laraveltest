resource "aws_ecs_cluster" "foo" {
  name = "microservices-${var.environment}"
}
