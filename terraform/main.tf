module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "hybrid-load-balancing"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "hybrid-load-balancing-target"
  instance_count         = 1

  ami                    = "ami-0b898040803850657"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  subnet_id              = "${module.vpc.public_subnets[0].id}"
  user_data = <<EOF
#!/bin/bash

sudo yum install git

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 10

git clone https://github.com/RafalWilinski/hybrid-load-balancing.git 
cd hybrid-load-balancing/ec2-app

PORT=3000 node app.js
EOF
}