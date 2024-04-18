terraform {

  backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "francesco"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "fiauuu"
    }
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2.0"
    }
  }

  required_version = ">= 1.8.0"
}

provider "aws" {
  region = "eu-north-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-01f320e5e4c1777a8"
  instance_type          = "t3.micro"
  user_data              = <<EOT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io 
sudo systemctl start docker
sudo systemctl enable docker
EOT
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  depends_on             = [aws_security_group.my_security_group]
}
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Security group for my application"

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
