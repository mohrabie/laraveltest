variable "region" {
  default = "eu-west-1"
}

variable "environment" {
  default = "production"
  type    = "string"
}

variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}
