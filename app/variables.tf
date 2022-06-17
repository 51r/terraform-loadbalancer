variable "ami_id" {
  description = "Specify AMI ID output from Packer"
}

variable "email" {
  description = "Specify the email for resource's tags"
}

variable "name" {
  description = "Specify the prefix name for the AWS resources"
}

variable "subnets_cidr" {
  description = "Specify the subnet CIDR block"
}

variable "azs" {
  description = "Specify Availability Zones"
}

variable "aws_vpc" {
  description = "Specify AWS VPC ID"
}
