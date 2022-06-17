variable "vpc_cidr" {
  description = "Specify VPC CIDR Block"
}

variable "email" {
  description = "Specify the email for resource's tags"
}

variable "name" {
  description = "Specify the prefix name for the AWS resources"
}

variable "subnets_cidr" {
  description = "Specify Subnets CIDR Blocks"
}

variable "azs" {
  description = "Specify AWS Availability Zones"
}
