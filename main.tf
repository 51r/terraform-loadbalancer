terraform {
  required_providers {
    aws = {
      version = ">= 4.18.0"
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.1.9"
}

module "sg" {
  source  = "./sg"
  aws_vpc = module.network.aws_vpc
  name    = var.name
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
  public_sg      = module.sg.public_sg
}

module "app" {
  source             = "./app"
  email              = var.email
  name               = var.name
  ami_id             = var.ami_id
  instances          = var.instances
  ec2                = module.app.ec2
  tg                 = module.lb.tg
  private_sg         = module.sg.private_sg
  private_subnets_id = module.network.private_subnets_id
}

output "public_url" {
  value = module.lb.dns
}