terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.9.0"
    }
  }
}

//Region where Central EventBus will exist
provider "aws" {
  region = "us-west-2"
  alias = "central"
}
    
//Region where current Eventbuses exist for fan-in
provider "aws" {
  region = "us-east-1"
  alias = "others"
}