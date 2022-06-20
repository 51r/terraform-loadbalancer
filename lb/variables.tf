variable "email" {
  description = "Specify the email for resource's tags"
}

variable "name" {
  description = "Specify the prefix name for the AWS resources"
}

variable "aws_vpc" {
  description = "Specify AWS VPC ID"
}

variable "public_subnets" {
  description = "Specify Public Subnets IDs"
}

variable "public_sg" {
  description = "Specify Public Security Group"
}