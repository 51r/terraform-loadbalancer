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
  source               = "./network"
  name                 = var.name
  email                = var.email
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
}

module "lb" {
  source         = "./lb"
  name           = var.name
  email          = var.email
  aws_vpc        = module.network.aws_vpc
  public_subnets = module.network.public_subnets
}

module "app" {
  source          = "./app"
  name            = var.name
  email           = var.email
  aws_vpc         = module.network.aws_vpc
  private_subnets = module.network.private_subnets
  ami_id          = var.ami_id
  instances       = var.instances
  tg              = module.lb.tg
  depends_on      = [module.network]
}

output "public_url" {
  value = module.lb.dns
}