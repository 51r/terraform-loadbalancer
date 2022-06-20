variable "name" {
  type        = string
  description = "Specify the prefix name for all AWS resources"
  default     = "peter"
}

variable "email" {
  type        = string
  description = "Specify the email for resource's tags"
  default     = "spasov@hashicorp.com"
}

variable "instances" {
  type        = string
  description = "Specify how much instances should be build, this number should be odd (2,4,6..)"
  default     = "6"
}

variable "ami_id" {
  type        = string
  description = "Specify AMI ID output from Packer"
  default     = "ami-0e8040f700cdfdd53"
}

variable "aws_region" {
  description = "Specify AWS Region"
  default     = "eu-west-2"
}

variable "azs" {
  type        = list(string)
  description = "Specify AWS Availability Zones"
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "vpc_cidr" {
  type        = string
  description = "Specify CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "Specify Private Subnets CIDR Blocks"
  default     = ["10.0.0.0/27", "10.0.1.0/27"]
}

variable "public_subnets_cidr" {
  description = "Specify Public Subnets CIDR Blocks"
  type        = list(string)
  default     = ["10.0.2.0/27", "10.0.3.0/27"]
}