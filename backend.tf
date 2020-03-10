terraform {
  backend "s3" {
    region = "us-west-2"
    bucket = "dev.eks.tfstate"
    key = "state.tfstate"
    encrypt = true
  }
}