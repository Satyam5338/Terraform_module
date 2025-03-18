provider "aws" {
  region = "ap-south-2" # Change this if needed
}

module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/24"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id # Passing VPC ID from the VPC module
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id           = "ami-0150f9c33a6958e02" # Ideally, pass this as a variable
  instance_type    = "t3.micro"
  subnet_id        = module.vpc.subnet_id
  security_group_id = module.security_group.security_group_id
  key_pair_name    = "spkey"
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.instance_public_ip
}
