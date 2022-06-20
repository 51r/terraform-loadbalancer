terraform {
  required_providers {
    aws = {
      version = ">= 4.18.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.9"
}


module "network" {
  source       = "./network"
  subnets_cidr = var.public_subnets_cidr
  email        = var.email
  name         = var.name
  vpc_cidr     = var.vpc_cidr
  azs          = var.azs
}

module "lb" {
  source         = "./lb"
  public_subnets = module.network.public_subnets
  email          = var.email
  name           = var.name
  aws_vpc        = module.network.aws_vpc
  ec2            = module.app.ec2
  instances      = var.instances
}

module "app" {
  source       = "./app"
  email        = var.email
  name         = var.name
  ami_id       = var.ami_id
  aws_vpc      = module.network.aws_vpc
  azs          = var.azs
  subnets_cidr = var.private_subnets_cidr
  instances    = var.instances
}

output "public_url" {
  value = module.lb.dns
}