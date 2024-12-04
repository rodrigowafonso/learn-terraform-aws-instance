terraform {
  backend "s3" {
    bucket = "rwa-terraform-jenkins"
    key    = "learn-terraform/tf/terraform_tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">=1.2.0"
}

provider "aws" {
  region = var.regiao_projeto
}

# resource "aws_instance" "learn-terraform-aws" {

#   ami           = "ami-012967cc5a8c9f891"
#   instance_type = "t2.micro"
  
#   tags = {

#     Name = var.instance_nome

#   }

# }
