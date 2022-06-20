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
  description = "Specify public subnets IDs"
}

variable "ec2" {
  description = "Specify EC2 Instances ID"
}

variable "instances" {
  description = "SPecify EC2 Instances count"
}