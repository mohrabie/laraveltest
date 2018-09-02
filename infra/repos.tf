resource "aws_ecr_repository" "laravel" {
  name = "laravel"
}

resource "aws_ecr_repository" "nginx" {
  name = "nginx"
}

