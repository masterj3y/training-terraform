terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

variable "environment" {}
variable "subnet_cidr_block" {}
variable "vpc_cidr_block" {}
variable "avail_zone" {}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.environment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "subnet-1-dev"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

output "default_vpc" {
  value = data.aws_vpc.existing_vpc.id
}
