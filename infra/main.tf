terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # Mumbai, change if you want
}

# Get latest Ubuntu 22.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Security group: allow SSH & Strapi port
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow SSH and Strapi port"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Strapi HTTP"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Use default VPC (simpler for beginner)
data "aws_vpc" "default" {
  default = true
}

# Get all subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


resource "aws_instance" "strapi" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro" # free tier; for heavier usage you may prefer t3.small

  subnet_id              = data.aws_subnet_ids.default.ids[0]
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]

  key_name = var.key_name     # You must create this key pair in AWS console first

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "strapi-ec2"
  }
}
