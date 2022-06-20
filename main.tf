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
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  email                = var.email
  name                 = var.name
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
}

module "lb" {
  source         = "./lb"
  public_subnets = module.network.public_subnets
  email          = var.email
  name           = var.name
  aws_vpc        = module.network.aws_vpc
}

module "app" {
  source             = "./app"
  depends_on = [module.network]
  email              = var.email
  name               = var.name
  ami_id             = var.ami_id
  instances          = var.instances
  ec2                = module.app.ec2
  tg                 = module.lb.tg
  aws_vpc = module.network.aws_vpc
  private_subnets = module.network.private_subnets
}

output "public_url" {
  value = module.lb.dns
}