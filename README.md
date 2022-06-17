# Terraform AWS Load Balancer Sample

This repo contains Terraform configuration with AWS Load Balancer in 2 Different AWS Availability Zones that contain 2 EC2 Instances.

It deploys total 18 resources in AWS:
* VPC With Private and Public Subnets. (5 Resources)
* EC2 Instances inside the Private Subnets in different AWS Availability Zones. (2 Resources)
* Application Load Balancer with Route Table, Listener, Internet Gateway and Target Groups with 2 attachments. (7 Resources)
* Security Groups - Private with HTTP Ports enabled and Public with all ports opened for the Load Balancer. (2 Resources)
* Route Table Associations for the Public Subnets. (2 Resources)

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
<img width="418" alt="Screen Shot 2022-06-17 at 2 15 53 PM" src="https://user-images.githubusercontent.com/52199951/174288093-8cf39398-2517-4f18-99e6-9052766ff448.png">


### 4. Initialize Terraform:
```
terraform init
```

### 5.Apply the plan:
```
terraform apply
```

* The terraform will deploy the AWS resources and will printout the Public URL for the Load Balancer:

<img width="1214" alt="Screen Shot 2022-06-17 at 2 13 43 PM" src="https://user-images.githubusercontent.com/52199951/174287869-d7bc463e-4a95-417d-9ca5-2901d9a5c3c5.png">

