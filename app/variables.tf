variable "ami_id" {
  description = "Specify AMI ID output from Packer"
}

variable "email" {
  description = "Specify the email for resource's tags"
}

variable "name" {
  description = "Specify the prefix name for the AWS resources"
}

variable "instances" {
  description = "Specify the number of instances"
}

variable "tg" {
  description = "Target Group"
}

variable "aws_vpc" {
  default = "AWS VPC ID"
}

variable "private_subnets" {
  description = "Private Subnets ID"
}