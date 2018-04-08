terraform {
  backend "s3" {
    bucket = "aws-bmc-tfstate"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}
