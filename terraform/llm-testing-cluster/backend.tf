terraform {
  backend "s3" {
    bucket = "kjr-llm-testing-terraform"
    key    = "cluster/terraform.tfstate"
    region = "ap-southeast-2"
  }
}