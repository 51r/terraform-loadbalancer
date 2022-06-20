# Terraform AWS Load Balancer Sample

This repo contains Terraform configuration with AWS Load Balancer in 2 Different AWS Availability Zones (in the guide I'm using `eu-west-2a` & `eu-west-2b`).

It deploys the following resources in AWS:
* VPC With Private and Public Subnets. 
* EC2 Instances inside the Private Subnets in different AWS Availability Zones. 
* Application Load Balancer with Route Table, Listener, Internet Gateway and Target Groups with 2 attachments. 
* Security Groups - Private with HTTP Ports enabled and Public with all ports opened for the Load Balancer. 
* Route Table Associations for the Public Subnets.

# Prerequisite

* Preinstalled [Terraform CLI >0.13](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* Configured AWS Credentials

# How to use the repo:

1. Clone Locally the repo:
```
git clone https://github.com/51r/terraform-loadbalancer.git
```

2. Make sure you are in the repo root:
```
cd terraform-loadbalancer
```

3. Add/Modify the variables inside variables.tf

| Variable | Description |
| --- | --- |
|name|Prefix for every AWS Resource to recognize them easily.|
|email|Email tag for the AWS Resources.|
|instances|Number of instances to be deployed.|
|ami_id|AMI ID for the instances|
|azs|AWS Availability Zones|
|vpc_cidr|CIDR Block for the VPC|
|private_subnets_cidr|CIDR Block for Private Subnets|
|public_subnets_cidr|CIDR Block for Public Subnets|

4. Initialize Terraform:
```
terraform init
```

5.Apply the plan:
```
terraform apply
```

* The terraform will deploy the AWS resources and will printout the outputs.

|Output | Description |
| --- | --- |
|public_url|The ARN of the AWS Elastic Load Balancer|

Your output should be simillar to:

```
public_url = "YOURPREFIX-lb-******.eu-west-2.elb.amazonaws.com"
```
