terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  alias = "central"
}
    
provider "aws" {
  region = "us-east-1"
  alias = "others"
}