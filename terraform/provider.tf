provider "aws" {
  region  = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "uk-police-data-backend-012985638193"
    key    = "application.tfstate"
    region = "eu-west-2"
  }
}