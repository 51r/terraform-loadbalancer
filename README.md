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

### 1. Clone Locally the repo:
```
git clone https://github.com/51r/terraform-loadbalancer.git
```

### 2. Make sure you are in the repo root:
```
cd terraform-loadbalancer
```

### 3. Add/Modify the variables inside variables.tf
<img width="453" alt="Screen Shot 2022-06-20 at 9 26 11 AM" src="https://user-images.githubusercontent.com/52199951/174538310-3014a42a-9bec-48b0-b771-03a2ee7ad081.png">


### 4. Initialize Terraform:
```
terraform init
```

### 5.Apply the plan:
```
terraform apply
```

* The terraform will deploy the AWS resources and will printout the Public URL for the Load Balancer:
<img width="521" alt="Screen Shot 2022-06-17 at 2 28 20 PM" src="https://user-images.githubusercontent.com/52199951/174289889-9e4850d0-a2f6-4250-9708-a5c27ecd8d2f.png">
