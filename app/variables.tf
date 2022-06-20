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

variable "ec2" {
  description = "ec2 names"
}

variable "private_sg" {
  description = "Private Security Group"
}

variable "private_subnets_id" {
  description = "Subnets ID from data block"
}