terraform {

  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "francesco"

    # The name of the Terraform Cloud workspace to store Terraform state files in
    workspaces {
      name = "fiauuu"
    }
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2"
    }
  }

  required_version = ">= 1.8.0"
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0914547665e6a707c"
  instance_type          = "t3.micro"
  user_data              = <<EOT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io 
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run --name=lr_6 -dp 80:80 darynaspyskan/repo1:frontend_lr4_5
sudo docker start lr_6
sudo docker run -d --name watchtower --restart=always -v/var/run/docker.sock:/var/run/docker.sock containrrr/watchtower --interval 30
EOT
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  depends_on             = [aws_security_group.my_security_group]
}
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for my application"
  vpc_id      = "vpc-06f549387bfec460a"

  # Define ingress (inbound) rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow inbound traffic from all IPv4 addresses
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from all IPv4 addresses
  }

  # Define egress (outbound) rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

}
